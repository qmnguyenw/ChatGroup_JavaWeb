/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dbcontext.DBContext;
import entity.Account;
import entity.Message;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author MSI
 */
public class GeneralDAO {
    
    private Connection con = null;
    
    public GeneralDAO() throws Exception{
        con = new DBContext().getConnection();
    }
    
    public Account getAccountByEmail(String email) throws Exception{
        String sql = "select * from Account where email = ?";
        
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("email"), rs.getString("password"), 
                        rs.getString("username"),rs.getString("fname"), rs.getString("lname"), 
                        rs.getBoolean("gender"), rs.getDate("createDate"));
            }
            return null;
        }catch(Exception e) {
            throw e;
        }
        
    }
    
    public Account getAccountByUsername(String username) throws Exception{
        String sql = "select * from Account where username = ?";
        
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(rs.getString("email"), rs.getString("password"), 
                        rs.getString("username"),rs.getString("fname"), rs.getString("lname"), 
                        rs.getBoolean("gender"), rs.getDate("createDate"));
            }
            return null;
        }catch(Exception e) {
            throw e;
        }
        
    }
    
    public void addAccount(Account account) throws Exception {
        String sql = "insert into Account " +
        "values(?,?,?,?,?,?,?)";
        
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, account.getEmail());
            st.setString(2, account.getPassword());
            st.setString(3, account.getUsername());
            st.setString(4, account.getFname());
            st.setString(5, account.getLname());
            st.setBoolean(6, account.isGender());
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            st.setString(7, f.format(account.getCreateDate()));
            st.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
            throw e;
        }
        
    }
    
    public void addMessage(Message message) throws Exception {
        String sql = "insert into [Message] values (?,?,?)";
        
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, message.getContent());
            st.setTimestamp(2, message.getCreateDate());
            st.setString(3, message.getSender());
//            st.setDate(2, new java.sql.Date(message.getCreateDate().getTime()));
            st.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public List<Message> getLast50Message() throws Exception {
        String sql = "select top 50 m.* from [Message] m order by m.createDate desc";
        
        try {
            List<Message> messageList = new ArrayList<>();
            PreparedStatement st = con.prepareStatement(sql);
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                messageList.add(new Message(rs.getString("content"),
                        rs.getTimestamp("createDate"), rs.getString("sender")));
            }
            Collections.reverse(messageList);
            return messageList;
        }catch(Exception e) {
            throw e;
        }
        
    }
    
}
