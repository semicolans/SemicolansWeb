<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SemicolansWeb.UserSite.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <!--Animated Css For Animation effects-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!--Wow Effect for Animate While Scrolling-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.js"></script>
    <script>
        var wow = new WOW(
            {
                boxClass: 'wow',      // animated element css class (default is wow)
                animateClass: 'animate__animated', // animation css class (default is animated)
                offset: 0,          // distance to the element when triggering the animation (default is 0)
                mobile: true,       // trigger animations on mobile devices (default is true)
                live: true,       // act on asynchronously loaded content (default is true)
                callback: function (box) {
                    // the callback is fired every time an animation is started
                    // the argument that is passed in is the DOM node being animated
                },
                scrollContainer: null,    // optional scroll container selector, otherwise use window,
                resetAnimation: true,     // reset animation on end (default is true)
            }
        );
        wow.init();
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000" style="padding-top: 70px;">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>

        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <img src="../Reports/Images/Company/Semicolans/Carousal3.jpg" alt="POS">
            </div>
            <div class="item">
                <img src="../Reports/Images/Company/Semicolans/Carousal4.jpg" alt="Web Development">
            </div>
            <div class="item">
                <img src="../Reports/Images/Company/Semicolans/Carousal2.jpg" alt="Samsung">
            </div>
            <div class="item">
                <img src="../Reports/Images/Company/Semicolans/Carousal1.jpg" alt="Samsung">
            </div>

        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <div class="container pt-5" style="margin-top: 10px;">
        <%--Section 2 Cart--%>
        <div class="card text-center">
            <div class="card-body">
                <p style="font-size:3vw;font-weight: bold;" class="card-title wow animate__zoomIn">Many of the leading retailers in Sri Lanka rely on SemicolansPOS to support their business on daily basis.</p>
                <p class="card-text wow animate__flipInX">Our team is ready to develop Your dream.</p>
                <a href="DisplayAllProducts.aspx" class="btn btn-primary wow animate__zoomIn">Go To Shop</a>
            </div>
        </div>

        <%--Section 3Who We Are--%>
        <div class="row" style="margin-top: 10px;margin-left:10px;">
            <div class="col-sm-6 wow animate__zoomIn">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">WHO WE ARE</h3>
                        <p class="card-text" style="text-align: justify;">
                            Semicolans comprises a team of highly motivated, innovative & experienced team of software engineers, who have years of experience 
                            in development & implementation of software projects both locally and overseas.
                        </p>
                        <%--<a href="#" class="btn btn-primary">Go somewhere</a>--%>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 wow animate__zoomIn">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">WHAT WE DO</h3>
                        <p class="card-text" style="text-align: justify;">
                            We are a total information technology service provider specialized in retail software and hardware solutions. 
                            Semicolans is a place for hard work, dedication, team spirit, customer loyalty and innovation. 
                            Our continuous research and development benefits our clients in many ways. We come up with solutions whenever you want 
                            to start or expand your business, try out new ventures etc. Our vast experience across many industries will ensure 
                            that you get the maximum return on investment of your IT budget by installing our systems in every aspect of your business. 
                            At Semicolans we believe in relationships, where our business is to look after your business!
                        </p>
                        <%--<a href="#" class="btn btn-primary">Go somewhere</a>--%>
                    </div>
                </div>
            </div>
        </div>
        <%--Section 4 How Its Work--%>
        <div class="row wow animate__zoomIn" style="margin-top: 10px; margin-left: 10px;">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">HOW WE DO IT</h3>
                        <p class="card-text" style="text-align: justify;">
                            We will analyze your Information Technology requirements and develop dynamic solutions, which will assist you to manage your 
                            business more effectively by having accurate information and total control over all operational areas. Every project 
                            undertaken by Semicolans is under the personal supervision of a Senior Project Panel. Each panel consists of a minimum of 5 years’ 
                            experienced team in the industry. Our experience in handling varied projects from small to large scale businesses will 
                            no doubt add greater value and justify your decision in selecting Semicolans as the total solutions provider for your IT requirements. 
                        </p>
                        <%--<a href="#" class="btn btn-primary">Go somewhere</a>--%>
                    </div>
                </div>
            </div>
        </div>
        <%--Section 5 Hundred Clients--%>
        <div class="card text-center wow animate__fadeInLeft"style="margin-top: 20px;">
            <div class="card-body">
                <p style="font-size:4vw;font-weight: bold;"class="card-title">With hundreds of clients, Semicolans is the must-have POS solution for anybody who is operating a retail business.</p>
            </div>
        </div>
    </div>
</asp:Content>

