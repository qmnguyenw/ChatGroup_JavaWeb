<%-- 
    Document   : chat_room
    Created on : Jul 9, 2019, 10:27:05 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <style type="text/css">
            .fb-header{
                width:100%;
                height:10%;
                position:absolute;
                background: #191818;
                vertical-align: middle;
                top:0;
                left:0;
                color:white;
                z-index:7;
                font-family:verdana;
                text-align:center;
                border-bottom: 1px solid #FF9900;
            }
            .fb-body{
                position:absolute;
                left:0px;
                top:80px;
                width:100%;
                height:90%;
                background-color: black;
            }
            #signout, #btSend {
                background-color: black;
                color: #FF9900;
                z-index:20;
                height:22px;
                width:70px;
                cursor:pointer;
                border: 1px solid #FF9900;
                border-radius: 3px;
            }
            .btSignout {
                float: right;
                margin-right: 10px;
            }
            .left{
                float:left;
                width:80%;
                height:80%;
                background-color:yellow;
                font-family:inherit;
                font-size:15 px;
                font-weight:bold; 
            }
            .headchatbox{
                width:100%;
                height:10%;
                background-color: #191818;
                color: #FF9900;
                font-family: Tahoma;
                padding-top: 5px;
                padding-left: 10px;
                border-bottom: 1px solid #FF9900;
            }
            .chatbox{
                text-align:left;
                margin:0 auto;
                margin-bottom:25px;
                padding:10px;
                background: #191818;
                height:270px;
                border:1px solid #ACD8F0;
                overflow:auto; 
            }
            .right{
                border-left: 1px solid #FF9900;
                border-bottom: 1px solid #FF9900;
                float:right;
                width:19.87%;
                height: 100%;
                background-color:black;
                font-family:inherit;
                font-size:15 px;
                font-weight:bold; 
            }
            .TextChat{
                width:100%;
                height:11%;
                background-color:green;
            }
            .colorUl {
                color: white;
            }
            .divText {
                color: #FF9900;
                font-family: Tahoma;
                font-size: 12px;
                margin-left: 10px;
                margin-bottom: 20px;
            }
            .myText{
                color: #00cc33;
                font-family: Tahoma;
                font-size: 12px;
                margin-left: 10px;
                margin-bottom: 20px;
            }
            #sendContainer {
                width:100%;
                height: 14%;
                background-color: black;
            }
            .send {
                margin-top: 25px;
                margin-left: 10px;
            }
            #textMessage {
                position: relative;
                height: 35px;
                width: 60%;
                border: 1px solid #FF9900;
                border-radius: 10px;
                background: black;
                color: #FF9900;
                padding-left: 10px;
            }
            input:focus,
            select:focus,
            textarea:focus,
            button:focus {
                outline: none;
            }
            #btSend:hover,#signout:hover {
                background-color: white; 
                color: black;
            }
            .scrollbar {
                float: left;
                overflow-y: scroll;
                width: 100%;
                height: 100%;
                background-color: black;
                overflow: auto;
                border-bottom: 1px solid #FF9900;
            }

            .force-overflow {
                min-height: 450px;
            }

            #style2::-webkit-scrollbar-track
            {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                border-radius: 10px;
                background-color: black;
            }

            #style2::-webkit-scrollbar
            {
                width: 12px;
                background-color: black;
            }

            #style2::-webkit-scrollbar-thumb
            {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
                background-color: #ff6600;
            }
            .gray:hover {
                background-color: #cccccc;
            }
            .onlineUser {
                color: #FF9900;
                font-family: Tahoma;
                font-size: 15px;
                margin-left: 10px;
                margin-bottom: 20px;
            }
            .onlineUserMe {
                color: #00cc33;
                font-family: Tahoma;
                font-size: 15px;
                margin-left: 10px;
                margin-bottom: 20px;
            }
            #onlineTitle {
                color: #FF9900; 
                padding-left: 10px; 
                padding-bottom: 10px;
                font-size: 20px; 
                border-bottom: 1px solid #FF9900;
            }
        </style>
    </head>

    <body>
        <div class="fb-header-base">
        </div>
        <div class="fb-header">
            <h3 style="vertical-align: middle;">Welcome to &nbsp;<img style="height:30px; vertical-align: middle;" src="img/HelloWorld.png"/></h3>
        </div>
        <div class="fb-body">

            <div class = "left" >
                <div class = "headchatbox">
                    <p>
                        Welcome, ${onlineUser.username}
                        <a href="signout" class="btSignout">
                            <button class="btSignout" id="signout" type="button">Log out</button>
                        </a>
                    </p>
                </div>
                <div class="scrollbar" id="style2">
                    <div id="chatArea" class="force-overflow">
                    </div>
                </div>
                <div id="sendContainer">
                    <input class="send" id="textMessage" spellcheck="false" autocomplete="off" type="text"/>
                    <input class="send" id="btSend" onclick="sendMessage()" value="Send" type="button" />
                </div>
            </div>
            <div class = "right">
                
                <p id="onlineTitle" >Online users</p>
                <div id="online">
                    
                </div>
                <!--<textarea id="textAreaUser" rows ="10" cols="50" readonly></textarea>-->
            </div>
        </div>

    </body>
    <script type="text/javascript">
        var input = document.getElementById("textMessage");
        input.addEventListener("keyup", function (event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                document.getElementById("btSend").click();
            }
        });
        var websocket = new WebSocket("ws://localhost:8080/WebSocket_ChatRoom/chatserver");
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
            var username = '${sessionScope.onlineUser.username}';
            if (message.data.startsWith("userList12345")) {
                var listUser = message.data.replace("userList12345-", "");
                var listUserArr = listUser.split("-");
                $('#online').empty();
                for (var i = 0; i < listUserArr.length; i++) {
                    if (listUserArr[i]==username) {
                        $('<p class=onlineUserMe>' + listUserArr[i] + '</p>').appendTo('#online');
                    }else {
                        $('<p class=onlineUser>' + listUserArr[i] + '</p>').appendTo('#online');
                    }
                }
                textAreaUser.value = listUser;
            } else {
                if (message.data.startsWith(username) || message.data.endsWith(username)) {
                    $('<p class=myText>' + message.data + '</p>').appendTo('#chatArea');
                }else {
                    $('<p class=divText>' + message.data + '</p>').appendTo('#chatArea');
                }
//                $('<p class=divText>' + message.data + '</p>').appendTo('#chatArea');
//                $('#chat-area').text($('#chat-area').text()+(message.data)) ;
                style2.scrollTop = style2.scrollHeight;
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
</html>