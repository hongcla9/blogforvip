<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="layout/header.jsp"%>

<div class="container">

	<c:forEach items="${boards.content}" var="board">
	    <div class="card m-2">
	        <div class="card-body">
	            <h4 class="card-title">${board.title}</h4>
	            <a href="#" class="btn btn-primary"  onclick="pgPayIMP(' ${board.id}')">상세보기</a>
	        </div>
	    </div>	
	</c:forEach>

<ul class="pagination justify-content-center">
  <c:choose>
  	<c:when test="${boards.first}">
  		<li class="page-item disabled"><a class="page-link" href="?page=${boards.number-1}">Previous</a></li>
  	</c:when>
  	<c:otherwise>
  		<li class="page-item"><a class="page-link" href="?page=${boards.number-1}">Previous</a></li>
  	</c:otherwise>
  </c:choose>
  
    <c:choose>
  	<c:when test="${boards.last}">
  		<li class="page-item disabled"><a class="page-link" href="?page=${boards.number+1}">Next</a></li>
  	</c:when>
  	<c:otherwise>
  		<li class="page-item"><a class="page-link" href="?page=${boards.number+1}">Next</a></li>
  	</c:otherwise>
  </c:choose>
  
</ul>
	

</div>


<!--  <button onclick="  IMP.request_pay">결제하기</button> -->
  
  
  <script>
  function pgPayIMP(boardId){
	  
	  var login ='${empty principal }';
	  if(login=="true"){
		  alert("로그인 후 이용 가능합니다.");
		  return ;
	  }
	  console.log("boardId 값  " , boardId);
	  
	  
	  if(confirm("결제 하시겠습니까?")){
		  
		  var IMP = window.IMP; // 생략 가능
		  IMP.init("imp95951354"); // 예: imp00000000
		  
  IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid: "order_no_0001-"+boardId, // 상점에서 관리하는 주문 번호
	    name : '주문명:결제테스트',
	    amount : 100,
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '홍윤은',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456'
	}, function(rsp) {
	    if ( rsp.success ) {
	    	console.log("/payments/complete " );
	    	
		    //결제 성공시 이동 페이지
	        location.href="${Home}/board/"+boardId;
	    	
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	jQuery.ajax({
	    		url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
	    		type: 'POST',
	    		dataType: 'json',
	    		data: {
		    		imp_uid : rsp.imp_uid
		    		//기타 필요한 데이터가 있으면 추가 전달
	    		}
	    	}).done(function(data) {
	    		
	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	    		if ( everythings_fine ) {
	    			
	    	    	console.log("everythings_fine " );
	    	    	console.log(data);
	    	    	console.log(everythings_fine);
	    	    	
	    			var msg = '결제가 완료되었습니다.';
	    			msg += '\n고유ID : ' + rsp.imp_uid;
	    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg += '\결제 금액 : ' + rsp.paid_amount;
	    			msg += '카드 승인번호 : ' + rsp.apply_num;
	    			
	    			alert(msg);
	    			
	    		    //결제 성공시 이동 페이지
	    			location.href="${Home}/board/"+boardId;
	    		} else {
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        console.log("결제 실패");
	        if(msg.indexOf("이미 결제가 이루어진 거래건입니다")!==-1){
	        	alert("결제 완료 처리 되어 페이지 이동 됩니다.");
	        	//결체 완료한 게시글은 바로 이동 처리
	        	location.href="${Home}/board/"+boardId;
	        	
	        	return;
	        }
	        alert(msg);
	    }
});
  
	  }
  }
  
  
  
//   function pgPayIMP2(boardId){
	  
// 	  if(confirm("결제 하시겠습니까?")){
		  
// 		  var IMP = window.IMP; // 생략 가능
// 		  IMP.init("imp95951354"); // 예: imp00000000
// 		  IMP.request_pay({
// 			    pg : 'chai',
// 			    pay_method : 'trans',
// 			    merchant_uid: "order_no_0001", //상점에서 생성한 고유 주문번호
// 			    name : '주문명:결제테스트',
// 			    amount : 10,
// 			    buyer_email : 'iamport@siot.do',
// 			    buyer_name : '구매자이름',
// 			    buyer_tel : '010-1234-5678',
// 			    buyer_addr : '서울특별시 강남구 삼성동',
// 			    buyer_postcode : '123-456',
// 			    m_redirect_url : '/payments/complete' // 예: https://www.my-service.com/payments/complete
// 			}, function(rsp) {
// 			    if ( !rsp.success ) {
// 			    	//결제 시작 페이지로 리디렉션되기 전에 오류가 난 경우
// 			        var msg = '오류로 인하여 결제가 시작되지 못하였습니다.';
// 			        msg += '에러내용 : ' + rsp.error_msg;
			        
// 			        alert(msg);
			        
			        
			    
// 			    }
			    
// 				    if(rep.success){
				    
// 				    }
				    
// 			});
		  
// 	  }
//   }
  
  
  
 
  </script>

</div>




<%@ include file="layout/footer.jsp" %>