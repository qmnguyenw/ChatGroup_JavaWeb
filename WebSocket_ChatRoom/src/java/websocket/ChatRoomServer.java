package websocket;

import dao.GeneralDAO;
import entity.Account;
import entity.Message;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chatserver", configurator = ChatRoomServerConfigurator.class)
public class ChatRoomServer {

    static Set<Session> users = Collections.synchronizedSet(new HashSet<>());
    static List<Message> messageList = Collections.synchronizedList(new ArrayList<>());

    static GeneralDAO dao;
    int currentSaveIndex;
    HandleMessageCache saveToDb;

    @OnOpen
    public void handleOpen(EndpointConfig config, Session session) throws Exception {
        users.add(session);
        session.getUserProperties().put("onlineUser", config.getUserProperties().get("onlineUser"));
        Account user = (Account) session.getUserProperties().get("onlineUser");
        //load message list
        if (messageList.isEmpty()) {
            dao = new GeneralDAO();
            messageList = Collections.synchronizedList(dao.getLast50Message());
            currentSaveIndex = messageList.size();
            saveToDb = new HandleMessageCache();
            saveToDb.start();
        }

        //load message on chat window
        if (messageList.size() >= 50) {
            
            for (int i = messageList.size() - 50; i < messageList.size(); i++) {
                Message m = messageList.get(i);
                session.getBasicRemote().sendText(m.getSender() + ": " + m.getContent());
            }
        } else {
            for (Message m : messageList) {
                System.out.println(m.getSender() + ": " + m.getContent());
                session.getBasicRemote().sendText(m.getSender() + ": " + m.getContent());
            }
        }

        session.getBasicRemote().sendText("You are chatting as " + user.getUsername());
        for (Session u : users) {
            u.getBasicRemote().sendText(onlineListStr());
            if (!u.equals(session)) {
                u.getBasicRemote().sendText(user.getUsername() + " have joined the chat room");
            }
        }
    }

    private String onlineListStr() {
        StringBuilder sb = new StringBuilder("userList12345");
        for (Session userSession : users) {
            sb.append("-" + ((Account) userSession.getUserProperties().get("onlineUser")).getUsername());
        }
        return sb.toString();
    }

    @OnMessage
    public void handleMessage(String message, Session userSession) throws IOException {
        Account user = (Account) userSession.getUserProperties().get("onlineUser");
        for (Session session : users) {
            session.getBasicRemote().sendText(user.getUsername() + ": " + message);
        }
        messageList.add(new Message(message, new Timestamp(System.currentTimeMillis()), user.getUsername()));
    }

    @OnClose
    public void handleClose(Session session) throws IOException {
        users.remove(session);
        if (users.isEmpty()) {
            System.out.println("no one in chat room");
            saveToDb.stop();
            for (int i = currentSaveIndex; i < messageList.size(); i++) {
                try {
                    dao.addMessage(messageList.get(i));
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            currentSaveIndex = 0;
            messageList.removeAll(messageList);
        }
        Account user = (Account) session.getUserProperties().get("onlineUser");
        for (Session u : users) {
            u.getBasicRemote().sendText(onlineListStr());
            if (!u.equals(session)) {
                u.getBasicRemote().sendText(user.getUsername() + " has left the chat room");
            }
        }
    }

    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }

    class HandleMessageCache extends Thread {

        @Override
        public synchronized void run() {
            boolean hasLoad = false;
            while (true) {
                if (messageList.size() % 50 == 0) {
                    if (messageList.size() % 50 != 0) {
                        hasLoad = false;
                    }
                    if (!hasLoad) {
                        System.out.println("loading new 50 messages to DB");
                        for (int i = currentSaveIndex; i < messageList.size(); i++) {
                            try {
                                dao.addMessage(messageList.get(i));
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        }
                        currentSaveIndex = messageList.size();
                        hasLoad = true;
                    }
                }
            }
        }

    }

}
