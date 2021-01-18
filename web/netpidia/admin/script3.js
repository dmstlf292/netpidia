	function update(id){
		document.update.id.value=id;
		document.update.submit();
	}

	function zipCheck(){
	url="../zipSearch.jsp?search=n";
	window.open(url,"post","toolbar=no ,width=500 ,height=300 ,directories=no,status=yes,scrollbars=yes,menubar=no");
	}

//profile
	function myprofile(id){
		document.detail.id.value=id;
		document.detail.submit();
	}
	function myprofileUpdate(id){
		document.update.id.value=id;
		document.update.submit();
	}


//product 

	function productDetail(productNo) {
		document.detail.productNo.value=productNo;
		document.detail.submit();
	}

	function productDelete(productNo) {
		document.del.productNo.value=productNo;
		document.del.submit();
	}

	function productUpdate(productNo){
		document.update.productNo.value=productNo;
		document.update.submit();
	}
//cart
	function cartadd(quantity){
		document.cartadd.quantity.value=quantity;
		document.cartadd.submit();
	}
		
	function cartUpdate(form){
		alert(form.flag.value);
		form.flag.value="update";
		form.submit();
	}
	
	function cartDelete(form) {
		form.flag.value="delete";
		form.submit();
	}


//order

	function orderDetail(productNo){
		document.detail.productNo.value=productNo;
		document.detail.submit();	
	}
	
	function orderUpdate(form){
		form.flag.value="update";
		form.submit();
	}
	
	function orderDelete(form) {
		form.flag.value="delete";
		form.submit();
	}
	

//order end