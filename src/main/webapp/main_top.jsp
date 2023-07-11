<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shop.SubCategoryBean"%>
<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.MainCategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mallCart" class="shop.mall.CartBean" scope="session"/>
<%
	request.setCharacterEncoding("utf-8");
	String sid = (String)session.getAttribute("sid");
	
	//System.out.println("입력한 id:" +sid);
	
	MainCategoryDAO mcdao = MainCategoryDAO.getInstance();
	ArrayList<MainCategoryBean> mainCategory = mcdao.getAllMainCategory();
	
	//System.out.println("메인카테고리 갯수 : " + mainCategory.size());
	
	SubCategoryDAO scdao = SubCategoryDAO.getInstance();
	
	Vector<ProductBean> cart = mallCart.getAllproduct(); 
	DecimalFormat df = new DecimalFormat("###,###"); 
	
	int cartTotalPrice = 0;
	
	String path = request.getContextPath();
	
%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>사고멍치 - 반려용품의 모든 것</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/logo/pawlogo.png">

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/tiny-slider.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/glightbox.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/main.css" />

</head>

<body>
    <!--[if lte IE 9]>
      <p class="browserupgrade">
        You are using an <strong>outdated</strong> browser. Please
        <a href="https://browsehappy.com/">upgrade your browser</a> to improve
        your experience and security.
      </p>
    <![endif]-->

    <!-- Preloader -->
    <div class="preloader">
        <div class="preloader-inner">
            <div class="preloader-icon">
                <span></span>
                <span></span>
            </div>
        </div>
    </div>
    <!-- /End Preloader -->

    <!-- Start Header Area -->
    <header class="header navbar-area">
        <!-- Start Topbar -->
        <div class="topbar" style="background-image:url('<%=request.getContextPath()%>/assets/images/babypink.jpeg')">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 col-md-4 col-12">
                        <div class="top-left">
                            <ul class="menu-top-link">
                                
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-12">
                        <div class="top-middle">
                            
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-12">
                        <div class="top-end">
                            <div class="user">
                                <i class="lni lni-user"></i>
                              <%
                               	if(sid!=null){
                               		if(sid.equals("admin")){
                                    	%>
                                    	admin님 <a href="<%=request.getContextPath()%>/shop/admin/admin_main.jsp">관리자홈|</a>
                                    	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
                                    	<%
                                    }else{
                                	%>
                               		 <%=sid %>님 <a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
                               		 <% 
                                    }
                                }else{
                                	%>
                                	Hello
                                	<%
                                }
                                %>
                            </div>
                            <%if(sid==null){ // 로그인하지 않았으면
                            	%>
                            <ul class="user-login">
                                <li>
                           
                                    <a href="<%=request.getContextPath()%>/login.jsp">로그인</a>
                                  
                                </li>
                                <li>
                                    <a href="<%=request.getContextPath()%>/shop/member/register.jsp">회원가입</a>
                                </li>
                            </ul>
                            <%
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Topbar -->
        <!-- Start Header Middle -->
        <div class="header-middle">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3 col-md-3 col-7">
                        <!-- Start Header Logo -->
                        <a class="navbar-brand" href="<%=request.getContextPath()%>/main.jsp">
                            <img src="<%=request.getContextPath()%>/assets/images/logo/sagomeongchi.png" alt="Logo">
                        </a>
                        <!-- End Header Logo -->
                    </div>
                    <div class="col-lg-5 col-md-7 d-xs-none">
                        <!-- Start Main Menu Search -->
                        <div class="main-menu-search">
                        	<%-- <img src="<%=request.getContextPath()%>/assets/images/logo/sagomeongchi.png" alt="Logo" height="100"> --%>
                            <!-- navbar search start -->
                            <!-- <div class="navbar-search search-style-5">
                                <div class="search-select">
                                    <div class="select-position">
                                        <select id="select1">
                                            <option selected>All</option>
                                            <option value="1">option 01</option>
                                            <option value="2">option 02</option>
                                            <option value="3">option 03</option>
                                            <option value="4">option 04</option>
                                            <option value="5">option 05</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="search-input">
                                    <input type="text" placeholder="Search">
                                </div>
                                <div class="search-btn">
                                    <button><i class="lni lni-search-alt"></i></button>
                                </div>
                            </div> -->
                            <!-- navbar search Ends -->
                        </div>
                        <!-- End Main Menu Search -->
                    </div>
                    <div class="col-lg-4 col-md-2 col-5">
                        <div class="middle-right-area">
                            <div class="nav-hotline">
                                <i class="lni lni-phone"></i>
                                <h3>고객센터 : 1234-5678
                                    <span>월-금 : 09:00-17:30 / <font color="red">OFF : 주말,공휴일</font></span>
                                </h3>
                            </div>
                            <div class="navbar-cart">
                                <div class="wishlist">
                                    <a href="javascript:void(0)">
                                        <i class="lni lni-heart"></i>
                                        <span class="total-items">0</span>
                                    </a>
                                </div>
                               <!--  장바구니 -->
                                <div class="cart-items"> 
                                    <a href="javascript:void(0)" class="main-btn">
                                        <i class="lni lni-cart"></i>
                                        <span class="total-items"><%=cart.size()%></span>
                                    </a>
                                    <!-- Shopping Item -->
                                    <div class="shopping-item">
                                        <div class="dropdown-cart-header">
                                            <span><%=cart.size()%> items</span>
                                            <a href="<%=request.getContextPath()%>/shop/display/cartList.jsp">View Cart</a>
                                        </div>
                                        <ul class="shopping-list">
                                        
                                            <%
                                            	for(ProductBean pb : cart){
                                            		cartTotalPrice += pb.getStock()*pb.getPrice();
                                            		%>
                                            		<li>
                                            		 <a href="javascript:void(0)" class="remove" title="Remove this item"><i
                                                        class="lni lni-close"></i></a>
                                              		 <div class="cart-img-head">
                                                   		 <a class="cart-img" href="product-details.html"><img
                                                            src="<%=request.getContextPath()%>/shop/productimg/<%=pb.getPimage()%>" alt="#"></a>
                                              		 </div>
                                              		 
                                              		   <div class="content">
                                                   		 <h4><a href="product-details.html">
                                                            <%=pb.getPname() %></a></h4>
                                                   		 <p class="quantity"><%=pb.getStock()%>개 - <span class="amount"><%=df.format(pb.getStock()*pb.getPrice())%>원</span></p>
                                              	 		</div>
                                          			 </li>
                                            		<%
                                            	}
                                            %>
                                            <%-- <li>
                                                <a href="javascript:void(0)" class="remove" title="Remove this item"><i
                                                        class="lni lni-close"></i></a>
                                                <div class="cart-img-head">
                                                    <a class="cart-img" href="product-details.html"><img
                                                            src="<%=request.getContextPath()%>/assets/images/header/cart-items/item2.jpg" alt="#"></a>
                                                </div>
                                                 <div class="content">
                                                    <h4><a href="product-details.html">Wi-Fi Smart Camera</a></h4>
                                                    <p class="quantity">1x - <span class="amount">$35.00</span></p>
                                                </div>
                                            </li> --%>
                                        </ul>
                                        <div class="bottom">
                                            <div class="total">
                                                <span>Total</span>
                                                <span class="total-amount"><%=df.format(cartTotalPrice)%>원</span>
                                            </div>
                                            <div class="button">
                                                <a href="<%=path %>/shop/display/orderconfirm.jsp?pno=00&pqty=00" class="btn animate">주문하기</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/ End Shopping Item -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <!-- Start Header Bottom -->
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 col-md-6 col-12">
                    <div class="nav-inner">
                        <!-- Start Mega Category Menu -->
                        <div class="mega-category-menu">
                            <span class="cat-button"><i class="lni lni-menu"></i>All Categories</span>
                            <ul class="sub-category">
                                <li><a href="<%=request.getContextPath()%>/shop/display/all_product.jsp">ALL</a></li>
                                <li><a href="<%=request.getContextPath()%>/shop/display/all_product_spec.jsp?pspec=NEW">NEW</a></li>
                                <li><a href="<%=request.getContextPath()%>/shop/display/all_product_spec.jsp?pspec=BEST">BEST</a></li>
                                <%
                                	for(MainCategoryBean mcb : mainCategory){ //메인카테고리
                                		%>
                                		<li><a href="<%=request.getContextPath()%>/shop/display/show_product.jsp?cname=<%=mcb.getMcname()%>"><%=mcb.getMcname()%>
                                		<%
                                		ArrayList<SubCategoryBean> subCategory = scdao.getAllSubCategory(mcb.getMcname());
                                		if(subCategory.size()!=0){ // 서브카테고리가 있으면
                                			%>
                                			<i class="lni lni-chevron-right"></i></a>
                                			 <ul class="inner-sub-category">
                                			<%
                                			for(SubCategoryBean scb : subCategory){
                                			%>
                                				<li><a href="<%=request.getContextPath()%>/shop/display/show_product.jsp?cname=<%=scb.getScname()%>"><%=scb.getScname() %></a></li>
                                			<%
                                			}//for
                                			%>
                                			</ul>
                                			<%
                                		}//if
                                		else{ //서브카테고리가 없으면
                                			%>
                                			</a></li>
                                			<%
                                		}
                                	}//for
                                %>
                              
                            </ul>
                        </div>
                        <!-- End Mega Category Menu -->
                        <!-- Start Navbar -->
                        <nav class="navbar navbar-expand-lg">
                            <button class="navbar-toggler mobile-menu-btn" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                                <span class="toggler-icon"></span>
                                <span class="toggler-icon"></span>
                                <span class="toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                                <ul id="nav" class="navbar-nav ms-auto">
                                    <li class="nav-item">
                                        <a href="<%=request.getContextPath()%>/main.jsp" class="active" aria-label="Toggle navigation">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-2" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">Pages</a>
                                        <ul class="sub-menu collapse" id="submenu-1-2">
                                            <li class="nav-item"><a href="<%=request.getContextPath()%>/shop/display/company.jsp">오프라인 매장</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-3" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">Event</a>
                                        <ul class="sub-menu collapse" id="submenu-1-3">
                                            <li class="nav-item"><a href="<%=request.getContextPath()%>/shop/display/Event.jsp">리뷰이벤트</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<%=request.getContextPath()%>/shop/board/board.jsp" aria-label="Toggle navigation">Q&A</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<%=request.getContextPath()%>/shop/display/mypage.jsp" aria-label="Toggle navigation">MyPage</a>
                                    </li>
                                    
                                </ul>
                            </div> <!-- navbar collapse -->
                        </nav>
                        <!-- End Navbar -->
                    </div>
                </div>
                 <div class="col-lg-4 col-md-6 col-12">
                    <!-- Start Nav Social -->
                    <div class="nav-social">
                        <h5 class="title">Follow Us:</h5>
                        <ul>
                            <li>
                                <a href="javascript:void(0)"><i class="lni lni-facebook-filled"></i></a>
                            </li>
                            <li>
                                <a href="javascript:void(0)"><i class="lni lni-twitter-original"></i></a>
                            </li>
                            <li>
                                <a href="javascript:void(0)"><i class="lni lni-instagram"></i></a>
                            </li>
                            <li>
                                <a href="javascript:void(0)"><i class="lni lni-skype"></i></a>
                            </li>
                        </ul>
                    </div>
                    <!-- End Nav Social -->
                </div>
            </div>
        </div>
        <!-- End Header Bottom -->
    </header>
    <!-- End Header Area -->
    
     <!-- Start Hero Area -->
    <section class="hero-area" id="context">
            