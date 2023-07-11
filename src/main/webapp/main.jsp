<%@page import="shop.ProductDAO"%>
<%@page import="shop.SubCategoryBean"%>
<%@page import="shop.SubCategoryDAO"%>
<%@page import="shop.MainCategoryBean"%>
<%@page import="shop.MainCategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="main_top.jsp" %>
<% 
	request.setCharacterEncoding("utf-8"); 
	String id = request.getParameter("id");

%>
    <!-- Start Hero Area -->
    <section class="hero-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-12 custom-padding-right">
                    <div class="slider-head">
                        <!-- Start Hero Slider -->
                        <div class="hero-slider">
                            <!-- Start Single Slider -->
                            <div class="single-slider"
                                style="background-image: url(assets/images/hero/slider-크런치팝.jpeg);">
                                <div class="content">
                                    <h2><span>신제품 발매기념 10% 할인!</span>
                                        강아지 시리얼 크런치팝
                                    </h2>
                                    <p></p>
                                    <h3><span>Now Only</span>13,500원</h3>
                                    <div class="btn btn-secondary">
                                        <a href="product-grids.html"><font color="red">♥</font></a>
                                    </div>
                                </div>
                            </div>
                            <!-- End Single Slider -->
                            <!-- Start Single Slider -->
                            <div class="single-slider"
                                style="background-image: url(assets/images/hero/bigdog.jpeg);">
                                <div class="content">
                                </div>
                            </div>
                            <!-- End Single Slider -->
                            <!-- Start Single Slider -->
                            <div class="single-slider"
                                style="background-image: url(assets/images/hero/Toyshop.jpeg);">
                                <div class="content">
                                </div>
                            </div>
                            <!-- End Single Slider -->
                            <!-- Start Single Slider -->
                            <div class="single-slider"
                                style="background-image: url(assets/images/hero/harim.jpeg);">
                                <div class="content">
                                    <!-- <h2><span>이제 봄이예요~!</span>
                                        벚꽃놀이하러 가자멍
                                    </h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                        incididunt ut labore et dolore magna aliqua.</p>
                                    <h3><span>Combo Only:</span> $590.00</h3>
                                    <div class="button">
                                        <a href="product-grids.html" class="btn">Shop Now</a>
                                    </div> -->
                                </div>
                            </div>
                            <!-- End Single Slider -->
                        </div>
                        <!-- End Hero Slider -->
                    </div>
                </div>
                <div class="col-lg-4 col-12">
                    <div class="row">
                        <div class="col-lg-12 col-md-6 col-12 md-custom-padding">
                            <!-- Start Small Banner -->
                            <div class="hero-small-banner"
                                style="background-image: url(assets/images/hero/hoogi_event.jpeg);">
                                <div class="content">
                                <br> <br> <br><br><br><br><br>
                                <br>
                                    <h2>
                                        <span>event</span>
                                        <font color="white">후기쓰고 우리집 댕댕이 화보찍자★</font>
                                    </h2>
                                    <h3></h3>
                                </div>
                            </div>
                            <!-- End Small Banner -->
                        </div>
                        <div class="col-lg-12 col-md-6 col-12">
                            <!-- Start Small Banner -->
                            <div class="hero-small-banner style2" style="background-image: url(assets/images/hero/oneplusone.jpeg);">
                                <div class="content">
                                    <!-- <h2><font color="black">간식 아울렛 오픈!</font></h2>
                                    <p>Saving up to 50% off all online store items this week.</p>
                                    <div class="button">
                                        <a class="btn" href="product-grids.html">Shop Now</a>
                                    </div> -->
                                </div>
                            </div>
                            <!-- Start Small Banner -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Hero Area -->
    <%
    	ProductDAO pdao = ProductDAO.getInstance();
    	String pspec = "BEST";
    	ArrayList<ProductBean> bestItem = pdao.getProductByPspec(pspec);
    %>

    <!-- Start Trending Product Area -->
    <section class="trending-product section" style="margin-top: 12px;">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-title">
                        <h2><font color="red">♥</font> BEST ITEMS <font color="red">♥</font></h2>
                        <p> 사고멍치 인기 아이템들을 지금 바로 만나보세요!</p>
                    </div>
                </div>
            </div>
            <div class="row">
            <% 
            	for(int i =0; i<bestItem.size(); i++){
            		%>
            	<div class="col-lg-3 col-md-6 col-12">
                    <!-- Start Single Product -->
                    <div class="single-product">
                        <div class="product-image">
                            <img src="assets/images/products/BEST/<%=bestItem.get(i).getPimage() %>" alt="#">
                            <div class="button">
                                <a href="<%=request.getContextPath()%>/shop/display/prod_view.jsp?pno=<%=bestItem.get(i).getPno()%>" class="btn"><i class="lni lni-cart"></i> 보러가기</a>
                            </div>
                        </div>
                        <div class="product-info">
                            <span class="category"><%=bestItem.get(i).getPcategory_fk() %></span>
                            <h4 class="title">
                                <a href="product-grids.html"><%=bestItem.get(i).getPname() %></a>
                            </h4>
                            <ul class="review">
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><span>5.0 Review(s)</span></li>
                            </ul>
                            <div class="price">
                                <span><%=df.format(bestItem.get(i).getPrice())%>원</span>
                            </div>
                        </div>
                    </div>
                    <!-- End Single Product -->
                </div>
            		<%
            	}
            %>
              </div>
        </div>
    </section>
      <!-- End Trending Product Area -->
            
    <!-- Start Call Action Area -->
    <section class="call-action section" style="background-image:url('assets/images/mintgreen.png')"> 
        <div class="container" >
            <div class="row ">
                <div class="col-lg-8 offset-lg-2 col-12">
                    <div class="inner">
                        <div class="content">
                           <h2 class="wow fadeInUp" data-wow-delay=".4s" style="font-color:black;">저희 사고멍치에서 판매하는 모든 제품은<br>
                                안전하고 위생적인 곳에서 생산한 제품입니다.</h2>
                            <p class="wow fadeInUp" data-wow-delay=".6s">Please, purchase full version of the template
                                to get all pages,<br> features and commercial license.</p>
                            <div class="button wow fadeInUp" data-wow-delay=".8s">
                                <a href="javascript:void(0)" class="btn">Purchase Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Call Action Area -->
    

    <!-- Start Banner Area -->
    <section class="banner section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="single-banner" style="background-image:url('assets/images/banner/itsdog.jpeg')">
                        <div class="content">
                            <h2></h2>
                            <p> <br><br><br><br></p>
                            <div class="button">
                                <a href="product-grids.html"></a>
                            </div> 
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="single-banner custom-responsive-margin"
                        style="background-image:url('assets/images/banner/safepatch.jpeg')">
                        <div class="content">
                          <h2></h2>
                            <p> <br><br><br><br> </p>
                            <div class="button"> 
                                <a href="product-grids.html"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Banner Area -->

    <!-- Start Shipping Info -->
    <section class="shipping-info">
        <div class="container">
            <ul>
                <!-- Free Shipping -->
                <li>
                    <div class="media-icon">
                        <i class="lni lni-delivery"></i>
                    </div>
                    <div class="media-body">
                        <h5>무료배송</h5>
                        <span>5만원 이상 주문시 무료배송</span>
                    </div>
                </li>
                <!-- Money Return -->
                <li>
                    <div class="media-icon">
                        <i class="lni lni-support"></i>
                    </div>
                    <div class="media-body">
                        <h5>24시 오픈채팅 상담</h5>
                        <span>카카오톡 '사고멍치' 친구추가</span>
                    </div>
                </li>
                <!-- Support 24/7 -->
                <li>
                    <div class="media-icon">
                        <i class="lni lni-credit-cards"></i>
                    </div>
                    <div class="media-body">
                        <h5>간편페이 사용가능</h5>
                        <span>카카오페이&네이버페이&페이코</span>
                    </div>
                </li>
                <!-- Safe Payment -->
                <li>
                    <div class="media-icon">
                        <i class="lni lni-reload"></i>
                    </div>
                    <div class="media-body">
                        <h5>간단한 환불&교환</h5>
                        <span>환불,교환 신청시 배송지앞으로 수거</span>
                    </div>
                </li>
            </ul>
        </div>
    </section>
    <!-- End Shipping Info -->

    <%@ include file="main_bottom.jsp" %>
