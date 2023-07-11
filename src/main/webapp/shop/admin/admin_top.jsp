<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>사고멍치 - 반려용품의 모든것</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/logo/pawlogo.png" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/tiny-slider.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/glightbox.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/main.css" />

	<style type="text/css">
	#admin{
		margin-top:10;
	}
	#admintitle{
		width:100%;
		text-align:right;
	}
	#context{
		height:800px;
	}
</style>
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

 <!-- Start Header Bottom -->
 <header>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 col-md-6 col-12">
                    <div class="nav-inner">
                        <!-- Start Mega Category Menu -->
                        <!-- <div class="mega-category-menu">
                            <span class="cat-button"><i class="lni lni-menu"></i>All Categories</span>
                            <ul class="sub-category">
                                <li><a href="product-grids.html">ALL</a></li>
                                <li><a href="product-grids.html">NEW</a></li>
                                <li><a href="product-grids.html">간식 <i class="lni lni-chevron-right"></i></a>
                                    <ul class="inner-sub-category">
                                        <li><a href="product-grids.html">전체보기</a></li>
                                        <li><a href="product-grids.html">수제간식</a></li>
                                        <li><a href="product-grids.html">껌간식</a></li>
                                        <li><a href="product-grids.html">음료</a></li>
                                    </ul>
                                </li>
                                <li><a href="product-grids.html">의류</a></li>
                                <li><a href="product-grids.html">산책용품</a></li>
                                <li><a href="product-grids.html">생활용품</a></li>
                            </ul>
                        </div> -->
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
                                        <a href="admin_main.jsp" class="active" aria-label="Toggle navigation">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-2" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">카테고리 관리</a>
                                        <ul class="sub-menu collapse" id="submenu-1-2">
                                            <li class="nav-item"><a href="category_list.jsp">카테고리 목록(수정,삭제)</a></li>
                                            <li class="nav-item"><a href="maincategory_input.jsp">상위 카테고리 등록</a></li>
                                            <li class="nav-item"><a href="subcategory_input.jsp">하위 카테고리 등록</a></li>
                                           
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-3" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">상품관리</a>
                                        <ul class="sub-menu collapse" id="submenu-1-3">
                                            <li class="nav-item"><a href="product_list.jsp">상품목록</a></li>
                                            <li class="nav-item"><a href="product_input.jsp">상품등록</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-4" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">주문내역 관리</a>
                                        <ul class="sub-menu collapse" id="submenu-1-4">
                                            <li class="nav-item"><a href="orders_list.jsp">주문내역</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="dd-menu collapsed" href="javascript:void(0)" data-bs-toggle="collapse"
                                            data-bs-target="#submenu-1-4" aria-controls="navbarSupportedContent"
                                            aria-expanded="false" aria-label="Toggle navigation">회원 관리</a>
                                        <ul class="sub-menu collapse" id="submenu-1-4">
                                            <li class="nav-item"><a href="members_list.jsp">가입회원 목록</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<%=request.getContextPath()%>/shop/board/board.jsp" aria-label="Toggle navigation">Q&A</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<%=request.getContextPath()%>/main.jsp?id=admin" aria-label="Toggle navigation">쇼핑몰홈</a>
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
                    	
                    	<table id="admintitle">
                    		<tr>
                    			<td>
                    			<br>
                    				<img id="admin" src="<%=request.getContextPath()%>/assets/images/header/admin_man_person_user_icon.png">
                    				<br>
                    			</td>
                    		</tr>
                    		<tr>
                    			<td>
                    				<h4>관리자용 홈페이지</h4>
                    			</td>
                    		</tr>
                    	</table>
                    </div>
                    <!-- End Nav Social -->
                </div>
            </div>
        </div>
        <!-- End Header Bottom -->
    </header>
    <!-- End Header Area -->
    <hr>
     <!-- Start Hero Area -->
    <section class="hero-area" id="context">