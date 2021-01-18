package netpidia;

import java.security.MessageDigest;

public class SHA256 {//이메일 인증코드 타고 인증하는것
	
	public static String getSHA256(String input) {//input =즉 이메일 값에 hash 를 적용한 값을 반환해서 이용하는것
		StringBuffer result = new StringBuffer();
		try {
			//사용자가 입력한 값을 SHA256으로 알고리즘 적용할 수 있도록 하기
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] salt ="Hello! this is Salt.".getBytes();//해킹방지
			digest.reset();
			digest.update(salt);//salt값을 적용하기
			//배열변수 만들기, Hash 로 적용한 값을 캐릭터 변수에 담기
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			//문자열 형태로 만들기
			for(int i=0; i<chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);//hax값과 현재 hash값을 적용한 캐릭터에 해당 인덱스르 &연산 해주기
				if(hex.length()==1) result.append("0");//1자리수인 경우? 0을 붙여서 2자리수를 가지는 16진수형태로 출력하기
				result.append(hex);//뒤에 hex값을  차근차근 달아서 해당 hash값을 반환하기
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();//결과반환
	}
	
}
