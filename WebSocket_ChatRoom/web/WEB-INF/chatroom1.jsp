<%-- 
    Document   : chatroom1
    Created on : Jul 12, 2019, 3:28:46 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Demo websocket</title>
        <style>
            #chat-area {
                float:left;
            }
            #online-area {
                float:left;
            }
        </style>

    </head>
    <body>

        <div id = "chat-area" >
            <h1>Demo WebSocket</h1>
            <form>
                <input id="textMessage" type="text" />
                <input onclick="sendMessage()" value="Send Message" type="button" /> <br/><br/>
            </form>
            <textarea id="textAreaMessage" rows="10" cols="50" readonly></textarea>


            <br><a href="signout">Log out</a>
        </div>
        <div id="online-area" >
            <h1>Online user </h1>
            <br><br>
            <textarea id="textAreaUser" rows ="10" cols="50" readonly></textarea>
        </div>
        <script type="text/javascript">
            var websocket = new WebSocket("ws://localhost:8080/WebSocket_StackJava_Chat/chatserver");
            websocket.onopen = function (message) {
                processOpen(message);
            };
            websocket.onmessage = function (message) {
                processMessage(message);
            };
            websocket.onclose = function (message) {
                processClose(message);
            };
            websocket.onerror = function (message) {
                processError(message);
            };
            function processOpen(message) {

            }
            function processMessage(message) {
                if (message.data.startsWith("userList12345")) {
                    var listUser = message.data.replace("userList12345\n", "");
                    textAreaUser.value = listUser;
                } else {
                    textAreaMessage.value += message.data + " \n";
                    textAreaMessage.scrollTop = textAreaMessage.scrollHeight;
//                    var textarea = document.getElementById('#textAreaMessage');
//                    textarea.scrollTop = textarea.scrollHeight;
                }
            }
            function processClose(message) {
                textAreaMessage.value += "Server Disconnect... \n";
            }
            function processError(message) {
                textAreaMessage.value += "Error... " + message + " \n";
            }
            function sendMessage() {
                if (typeof websocket != 'undefined' && websocket.readyState == WebSocket.OPEN) {
                    websocket.send(textMessage.value);
                    textMessage.value = "";
                }
            }
        </script>
    </body>
</html>

