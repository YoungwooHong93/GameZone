/*
 < ** 입력값의 무결성 확인 >
  ** user 무결성 확인사항
  ID : 길이(5이상 10이하), 영문자, 숫자로만 구성
  Password : 길이(8이상 15이하), 영문, 숫자, 특수문자로 구성, 특수문자는 반드시 1개 이상 포함할 것
  Name : 길이(2이상), 영문 또는 한글로만 입력
  BirthDay : 입력 여부 확인 ( length == 10 )
  Email : 직접입력이나 select 했는지
  Phone : '-' 없이 숫자 11자리 입력했는지
 */

function idCheck() {

	let id = $('#id').val();

	if (id.length < 5 || id.length > 10) {
		$('#iMessage').html('ID는 5 ~ 10자리까지 사용 가능합니다.');
		return false;

	} else if (id.replace(/[a-z.0-9]/g, '').length > 0) {
		$('#iMessage').html('ID는 알파벳 소문자, 숫자로만 입력해주세요.');
		return false;

	} else {
		$('#iMessage').html('');
		return true;
	}

} // idCheck

//--------------------------------------------------------------------------------------

function opwCheck() {

	let oldPassword = $('#oldPassword').val();

	if (oldPassword.length < 8 || oldPassword.length > 15) {
		$('#opMessage').html('비밀번호는 8 ~ 15자리입니다.');
		return false;

	} else if (oldPassword.replace(/[!-*.@]/gi, '').length >= oldPassword.length) {
		$('#opMessage').html('비밀번호에는 특수문자가 반드시 포함되어야 합니다.');
		return false;

	} else if (oldPassword.replace(/[a-z.0-9.!-*.@]/gi, '').length > 0) {
		$('#opMessage').html('비밀번호는 영문자, 숫자, 특수문자로만 입력해주세요.');
		return false;

	} else {
		$('#opMessage').html('');
		return true;
	}

} // opwCheck

//--------------------------------------------------------------------------------------

function pwCheck() {

	let password = $('#password').val();

	if (password.length < 8 || password.length > 15) {
		$('#pMessage').html('비밀번호는 8 ~ 15자리입니다.');
		return false;

	} else if (password.replace(/[!-*.@]/gi, '').length >= password.length) {
		$('#pMessage').html('비밀번호에는 특수문자가 반드시 포함되어야 합니다.');
		return false;

	} else if (password.replace(/[a-z.0-9.!-*.@]/gi, '').length > 0) {
		$('#pMessage').html('비밀번호는 영문자, 숫자, 특수문자로만 입력해주세요.');
		return false;

	} else {
		$('#pMessage').html('');
		return true;
	}

} // pwCheck

//--------------------------------------------------------------------------------------

function pw2Check() {

	let password = $('#password').val();
	let password2 = $('#password2').val();

	if (password != password2) {
		$('#ppMessage').html('비밀번호가 다릅니다.');
		return false;

	} else if (password2.length < 8 || password2.length > 15) {
		$('#ppMessage').html('비밀번호는 8 ~ 15자리입니다.');
		return false;

	} else {
		$('#ppMessage').html('');
		return true;
	}

} // pw2Check

//--------------------------------------------------------------------------------------

function nmCheck() {

	let name = $('#user_name').val();

	if (name.length < 2 || name.length > 10) {
		$('#nMessage').html('이름은 2 ~ 10자리까지 입력 가능합니다.');
		return false;

	} else if (name.replace(/[a-z.가-힣]/gi, '').length > 0) {
		$('#nMessage').html('이름은 영문, 한글만 입력 가능합니다.');
		return false;

	} else {
		$('#nMessage').html('');
		return true;
	}

} // nmCheck

//--------------------------------------------------------------------------------------

// ** BirthDay Check

function bdyearCheck() {

	let year = $('#birth_year').val();
	
	if (year == null) {
		$('#bMessage').html('연도를 정확하게 선택 해주세요.');
		return false;
		
	} else {
		$('#bMessage').html('');
		return true;
	}

} // bdyearCheck

function bdmonthCheck() {

	let month = $('#birth_month').val();

	if (month == null) {
		$('#bMessage').html('월을 정확하게 선택 해주세요.');
		return false;
		
	} else {
		$('#bMessage').html('');
		return true;
	}
} // bdmonthCheck

function bddayCheck() {

	let day = $('#birth_day').val();
	
	if (day == null) {
		$('#bMessage').html('일을 정확하게 선택 해주세요.');
		return false;
		
	} else {
		$('#bMessage').html('');
		return true;
	}

} // bddayCheck

/*
function bdCheck() {

	let year = $('#birth_year').val();
	let month = $('#birth_month').val();
	let day = $('#birth_day').val();

	if (year == null || month == null || day == null) {
		$('#bMessage').html('생년월일을 정확하게 선택 해주세요.');
		return false;

	} else {
		$('#bMessage').html('');
		return true;
	}

} // bdCheck
*/
//--------------------------------------------------------------------------------------

function phoCheck() {

	let phone = $('#phone').val();

	if (phone.length < 10 || phone.length > 11) {
		$('#phMessage').html('11자리 핸드폰 번호를 입력해주세요.');
		return false;

	} else if (phone.replace(/[0-9]/gi, '').length > 0) {
		$('#iMessage').html('010부터 숫자만 입력해주세요.');
		return false;

	} else {
		$('#phMessage').html('');
		return true;
	}

} // phoCheck

//--------------------------------------------------------------------------------------

// ** email (@ 앞 부분)
function emaCheck() {

	let email = $('#email').val();

	if (email.length < 1) {
		$('#emMessage').html('이메일을 입력해주세요.');
		return false;

	} else if (email.length > 20) {
		$('#emMessage').html('이메일은 20자리만 입력 가능합니다.');
		return false;

	} else if (email.replace(/[a-z.0-9._\-]/gi, '').length > 0) {
		$('#emMessage').html('이메일은 알파벳, 숫자, 특수기호 : 언더바[ _ ], 하이픈[ - ])으로만 입력해주세요.');
		return false;

	} else {
		$('#emMessage').html('');
		return true;
	}

} // emaCheck

//--------------------------------------------------------------------------------------

// ** domain(직접입력)
function dowCheck() {

	let dowrite = $('#dw').val();
	let email = $('#email').val();

	if (dowrite.length < 1) {
		$('#emMessage').html('도메인을 직접 입력해주세요.');
		return false;

	} else if (email.length + dowrite.length > 30) {
		$('#emMessage').html('전체 이메일은 30자리까지만 입력 가능합니다.');
		return false;

	} else if (dowrite.replace(/[a-z.0-9.@]/gi, '').length > 0) {
		$('#emMessage').html('도메인은 알파벳, 숫자, [@], [.]으로만 입력해주세요.');
		return false;

	} else if (dowrite.replace('@', '').length >= dowrite.length) {
		$('#emMessage').html('이메일 형식이 아닙니다. [@]을 입력해주세요.');
		return false;

	} else if (dowrite.replace('.', '').length >= dowrite.length) {
		$('#emMessage').html('이메일 형식이 아닙니다. [.]을 입력해주세요.');
		return false;

	} else {
		$('#emMessage').html('');
		return true;
	}

} // dowCheck

//--------------------------------------------------------------------------------------

// ** domain(선택)
function doCheck() {

	let domain = $('#domain').val();
	let email = $('#email').val();

	if (email.length + domain.length > 30) {
		$('emMessage').html('전체 이메일은 30자리까지만 입력 가능합니다.');
		return false;

	} else {
		$('#emMessage').html('');
		return true;
	}

} // doCheck

