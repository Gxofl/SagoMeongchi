/**
 * 
 */

var isCheck;
var use;
var pwuse;
var pwsame;

 function writeSave(){
	
	if($('input[name=id]').val()==""){
		alert("아이디를 입력하세요");
		$('input[name=id]').focus();
		return false;
	}
	if(isCheck==false){
		alert("중복체크를 하세요");
		return false;
	}else if(use=="missing"){
		alert("아이디를 입력하세요");
		$('input[name=id]').focus();
		return false;
	}else if(use=="impossible"){
		alert("중복된 아이디입니다");
		$('input[name=id]').select();
		return false;
	}
	
	if($('input[name=password]').val()==""){
		alert("비밀번호를 입력하세요");
		$('input[name=password]').focus();
		return false;
	}
	if(pwuse=="pwerror"){
		alert("올바르지 못한 비밀번호 입니다");
		$('input[name=password]').focus();
		return false;
	}
	
	if($('input[name=passwordchk]').val()==""){
		alert("비밀번호를 확인하세요");
		$('input[name=passwordchk]').focus();
		return false;
	}
	if(pwsame=="no"){
		alert("비밀번호가 같지 않습니다");
		$('input[name=passwordchk]').focus();
		return false;	
	}
	
	if($('input[name=name]').val()==""){
		alert("이름을 입력하세요");
		$('input[name=name]').focus();
		return false;
	}
	
	if($('input[name=birth]').val()==""){
		alert("생년월일을 입력하세요");
		$('input[name=birth]').focus();
		return false;
	}
	
	if($('input[name=email]').val()==""){
		alert("이메일을 입력하세요");
		$('input[name=email]').focus();
		return false;
	}
	
	if($('input[name=address]').val()==""){
		alert("주소를 입력하세요");
		$('input[name=address]').focus();
		return false;
	}
	
}//writeSave

	function idCheck(){
		isCheck = true;
		
		$.ajax({
			url : "id_check_Proc.jsp",
			data : ({
				userId : $('input[name=id]').val()
			}),
			success : function(data){
				if($('input[name=id]').val()==""){
					$('#idcheck').html("<font color='red'>아이디를 입력하세요</font>");
					$('input[name=id]').focus();
					$('#idcheck').show();
					use="missing";
				}
				else if($.trim(data)=="NO"){ //중복
					$('#idcheck').html("<font color='red'>이미 있는 아이디 입니다</font>");
					use="impossible";
					$('#idcheck').show();
				}
				else if($.trim(data)=="YES"){
					$('#idcheck').html("<font color='blue'>사용가능한 아이디 입니다</font>");
					$('#idcheck').show();
					use="possible";
				}
			}
		})//ajax
	}//idcheck()
	
	function resetidCheck(){
		isCheck = false;
		use = "";
		$('#idcheck').css('display', 'none');
	}//resetidCheck()
	
	function pwformatcheck(){ //비밀번호 형식
		// 영문 숫자 조합 5~10자
		pw = $('input[name=password]').val();
		
		var regex = /^[a-z,0-9]{5,10}$/i;
		
		if(!regex.test(pw)){
			//alert("올바르지 못한 형식입니다");
			$('input[name=password]').select();
			$('#pwformatcheck').html("<font color='red'>비밀번호는 영문과 숫자 조합으로 5~10자 입력하세요</font>")
			$('#pwformatcheck').show();	
			
			pwuse="pwerror";
			
			return;	
		}
		else{
			$('#pwformatcheck').css('display','none');		
		}
		
		var chk_num = pw.search(/[0-9]/); //pw에 숫자의 위치를 찾아라 없을경우 -1
		var chk_eng = pw.search(/[a-z]/i); //알파벳의 위치를 찾아라
	
		//alert(chk_num + "," + chk_eng); //pw : ab3 => 2,0 aaa=> -1, 0 
		if(chk_num < 0 || chk_eng < 0){
			alert('비밀번호는 영문자와 숫자의 조합으로 작성하세요');
			pwuse = "pwerror";
		}else{
			pwuse = "";
		}
			
	}//pwformatcheck
	
	function pwcheck(){ //비밀번호 확인
		if($('input[name=password]').val()!=$('input[name=passwordchk]').val()){
			$('#pwcheck').html('<font color="red">비밀번호가 일치하지 않습니다</font>');
			pwsame="no";
		}else{
			$('#pwcheck').html('<font color="green">비밀번호가 일치합니다</font>');		
			pwsame="yes";	
		}
	}//pwcheck()

	
	function inputMainCategory(){
		if($('input[name=mcname]').val()==""){
			alert("이름을 입력하세요");
			$('input[name=mcname]').focus();
			return false;
		}
	}
	
	function inputSubCategory(){
		//alert(1);
		if($('select[name=supercname]').val()=="선택"){
			alert("상위 카테고리를 선택하세요");
			$('select[name=supercname]').focus();
			return false;
		}
		
		if($('input[name=scname]').val()==""){
			alert("하위 카테고리 이름을 입력하세요");
			$('input[name=scname]').focus();
			return false;
		}
		
	}