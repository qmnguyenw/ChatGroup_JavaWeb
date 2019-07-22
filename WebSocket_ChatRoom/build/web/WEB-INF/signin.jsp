<%-- 
    Document   : signin
    Created on : Jul 9, 2019, 10:48:20 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <title>Facebook Style Homepage Design using HTML and CSS</title>
    <head>
        <!--<link type="text/css" rel="stylesheet" href="style.css" /> -->
        <meta name="Description" content="Log in"/>
        <style type="text/css">
            body{
                background-image: url("grid.png");
                height:750px;
                background-color: #F1F3F4;
            }
            .fb-header-base{
                width:100%;
                height:90px;
                position:absolute;
                top:0;
                left:0;
                color:white;
                z-index:7;
                font-family:verdana;
                -webkit-box-shadow: 0 3px 8px rgba(0, 0, 0, .25);
            }
            .fb-header{
                width:100%;
                height:90px;
                position:absolute;
                background:#191818;
                top:0;
                left:0;
                color:white;
                z-index:7;
                font-family:verdana;

            }
            #img1{
                left:178px;
                height:50px;
                width:100px;
                top:25px;
            }
            #form1{
                left:750px;
                height:60px;
                width:180px;
                top:20px;
                font-family:verdana;
                font-size:12px;
            }
            #form2{
                left:940px;
                height:60px;
                width:250px;
                top:20px;
                font-family:verdana;
                font-size:12px;
            }
            #submit1{
                left:1130px;
                top:35px;
                background-color: #FF9900;
                color:black;
                position:absolute;
                z-index:20;
                height:22px;
                width:50px;
                cursor:pointer;
                border: none;
                border-radius: 3px;
            }

            .fb-body{
                position:absolute;
                left:0px;
                top:90px;
                width:100%;
                height:693px;


            }
            #intro1{
                left:178px;
                top:20px;
                font-family:verdana;
                font-size:20px;
                color:#142170;
                height:75px;
                width:550px;
            }
            #intro2{
                left:750px;
                top:20px;
                font-family:verdana;
                font-size:30px;
                color:#000;
                font-weight:bold;
                height:75px;
                width:500px;
            }
            #img2{
                top:130px;
                left:178px;
                width:537px;
                height:195px;
            }
            #intro3{
                left:750px;
                top:70px;
                font-family:verdana;
                font-size:18px;
                color:#000;
                height:50px;
                width:300px;
            }
            #form3{
                top:120px;
                left:750px;
                font-family:verdana;
                font-size:20px;
                color:#142170;
                width:450px;
                height:495px;

            }
            .textbox{

                height:30px;
                border-radius:5px 5px 5px 5px;
                background:white;
                padding:10px;
                font-size:18px;
                margin-top:8px;
                border-width: 1px;
                border-style:solid;
                border-color: gray;
            }
            #fnamebox,#datebox {
                width:200px;
            }
            #lnamebox {
                width:179px;
            }
            #mailbox, #remailbox, #passwordbox, #usernamebox{
                width:408px;
            }
            #r-b{
                font-size:12px;
                height:15px;
                width:15px;
            }
            .button2{
                width:250px;
                height:40px;
                left:750px;
                top:625px;
                background:#FF9900;
                font-family:verdana;
                font-size:18px;
                color:black;
                border-radius:5px 5px 5px 5px;
                border-width: 1px;
                border-style:solid;
                border-color: gray;
                cursor:pointer;
                outline:none;

            }
            #intro4{
                font-family:verdana;
                font-size:12px;
                color:gray;
            }
            #intro5{
                font-family:verdana;
                font-size:14px;
                color:gray;

            }
            .fb-body-footer{
                width:100%;
                position:relative;
                left:0px;
                height:80px;
                background:#F1F3F4;
                margin-top:20px;

            }
            #fb-body-footer-base {
                margin-top: 70px;
                width:1000px;
                top:15px;
                left:200px;
                color:blue;
                height:60px;
            }		
            .errorLb {
                color: red;
                font-size: 15px;
            }
            #img2 {
                width: 50px;
            }
            
        </style>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <script type="text/javascript">
            function checkSignUp() {
                var fname = $('#fnamebox').val();
                var lname = $('#lnamebox').val();
                var email = $('#mailbox').val();
                var remail = $('#remailbox').val();
                var password = $('#passwordbox').val();
                var result = true;
                $('#nameLb').text('');
                $('#mailLb').text('');
                $('#remailLb').text('');
                $('#passwordLb').text('');
                $('#usernameLb').text('');
                if (!/^\D*$/.test(fname)) {
                    $('#nameLb').text("First name cannot contain number");
                    result = false;
                }
                if (!/^\D*$/.test(lname)) {
                    $('#nameLb').text("Last name cannot contain number");
                    result = false;
                }
                if (!/^[0-9a-zA-Z_-]{1,}@{1}[a-z]{1,}\.{1}[a-z\.]{1,}$/.test(email)) {
                    $('#mailLb').text("Email must in format xxxx@xxx.xxx");
                    result = false;
                }
                if (remail !== email) {
                    $('#remailLb').text("Re-enter email must be the same as email");
                    result = false;
                }
                if (password.length < 6) {
                    $('#passwordLb').text("Password length must greater than 6.");
                    result = false;
                }
                if (!/^[A-Za-z0-9]{1,}$/.test(password)) {
                    $('#passwordLb').text("Password cannot contain special characters");
                    result = false;
                }
                return result;
            }
        </script>

    </head>
    <body>
        <div id="big-container">
            <div class="fb-header-base">
            </div>
            <form action="signin" method="post">
                <div class="fb-header">
                    <div id="img1" class="fb-header"><img style="height:40px;" src="${pageContext.request.contextPath}/img/HelloWorld.png"/></div>
                    <div id="form1" class="fb-header">Username or Email<br>
                        <input id="login-email" placeholder="Username" type="text" spellcheck="false" name="email" required="true" value="${email}" /><br>
                        <p style ="color:#FF9900">${errorLb}</p>
                    </div>

                    <div id="form2" class="fb-header">Password<br>
                        <input id="login-password" placeholder="Password" type="password" name="password" required="true" value="${password}" /><br>
                    </div>
                </div>
                <input type="submit" id="submit1" value="Login" />
            </form>
            <div class="fb-body">
                <div id="intro1" class="fb-body">HelloWorld helps you connect and share with the <br>
                    people in your life.</div>
                <div id="intro2" class="fb-body">Create an account</div>
                <div id="img2" class="fb-body"><img style="width:500px;" src="img/bia.png" /></div>
                <div id="intro3" class="fb-body">It's free and always will be.</div>
                <div id="form3" class="fb-body">
                    <form action ="signup" method ="post" onsubmit="return checkSignUp()">
                        <input placeholder="First Name" type="text" id="fnamebox" class="textbox" name="fname" required="true"
                               value="${fname}" />
                        <input placeholder="Last Name" type="text" id="lnamebox" class="textbox" name="lname" required="true"
                               value="${lname}" />
                        <span id="nameLb" class="errorLb"> </span><br>
                        <input placeholder="Username" type="text" id="usernamebox" class="textbox" name="username" required="true"
                               value="${param.username}" />
                        <span id="usernameLb" class="errorLb">${usernameLabel}</span><br>
                        <input placeholder="Email" type="text" id="mailbox" class="textbox" name="email" required="true"
                               value="${email}" />
                        <span id="mailLb" class="errorLb">${emailLabel}</span><br>
                        <input placeholder="Re-enter email" type="text" id="remailbox" class="textbox" name="remail" required="true"
                               value="${remail}" />
                        <span class="errorLb" id = "remailLb"> </span><br>
                        <input placeholder="Password" type="password" id="passwordbox" class="textbox" required="true" name="password"
                               value="${password}" />
                        <span class="errorLb" id="passwordLb"> </span><br><br>
                        <input type="radio" id="r-b" name="gender" value="male" checked />Male
                        <input type="radio" id="r-b" name="gender" value="female" ${genderStr=="female"?"checked":""} />Female<br><br>
                        <p id="intro4">By clicking Create an account, you agree to our Terms and that 
                            you have read our Data Policy, including our Cookie Use.</p>
                        <button type="submit" class="button2" >Create an account</button>
                        <br><hr>
                        <p id="intro5">Create a Page for a celebrity, band or business.</p>
                    </form>
                </div>

            </div>
<!--            <div class="fb-body-footer">
                <div id="fb-body-footer-base" class="fb-body-footer">English (UK)<br><hr>
                    Sign Up	Log In	&copy; www.hello.com &nbsp;&nbsp; Design by Quang
                </div>
            </div>-->
        </div>
    </body>

</html>

