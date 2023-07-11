<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="main_top.jsp" %>
<style>
	#logintable{
		margin : auto;
		width : 100%;
	}
	.btn-color{
 	 background-color: #0e1c36;
 	 color: #fff;
	}

	.profile-image-pic{
 	 height: 200px;
 	 width: 200px;
 	 object-fit: cover;
	}
	.cardbody-color{
 	 background-color: #ebf2fa;
	}
	a{
 	 text-decoration: none;
	}
</style>
<div class="container">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <div class="card my-5">

          <form class="card-body cardbody-color p-lg-5" action="loginProc.jsp" style="background-image:url('<%=request.getContextPath()%>/assets/images/lightyellow.png')">

            <div class="text-center">
           <!--  "https://cdn.pixabay.com/photo/2016/03/31/19/56/avatar-1295397__340.png" -->
              <img src="<%=request.getContextPath()%>/assets/images/login.jpeg" class="img-fluid profile-image-pic img-thumbnail rounded-circle my-3"
                width="200px" alt="profile">
                <br>
            </div>

            <div class="mb-3">
              <input type="text" class="form-control" name="id" id="Username" aria-describedby="emailHelp"
                placeholder="ID">
            </div>
            <div class="mb-3">
              <input type="password" class="form-control" name="password" id="password" placeholder="PW">
            </div>
            <div class="text-center">
            	<button type="submit" class="btn btn-secondary" >로그인</button>
            </div>
            <div>
            	<table id="logintable">
            		<tr>
            			<td><br></td>
            		</tr>
            		<tr>
            			<td width="50%" align="right">
            				<input type="button" class="btn btn-info" value="아이디찾기" onClick="location.href='<%=request.getContextPath()%>/shop/member/findid.jsp'">
            			</td>
            			<td width="50%" align="left">
            				<input type="button" class="btn btn-info" value="비밀번호찾기" onClick="location.href='<%=request.getContextPath()%>/shop/member/findpw.jsp'">
            			</td>
            		</tr>
            		<tr>
            			<td><br></td>
            		</tr>
            	</table>
         	</div>
            <div id="emailHelp" class="form-text text-center mb-5 text-dark">등록되지 않은 회원이십니까? 
            	<a href="<%=request.getContextPath()%>/shop/member/register.jsp" class="text-dark fw-bold"> 
            	회원가입</a>
            </div>
          </form>
        </div>

      </div>
    </div>
  </div>

<%@ include file="main_bottom.jsp" %>