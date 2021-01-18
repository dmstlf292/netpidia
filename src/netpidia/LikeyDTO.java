package netpidia;

public class LikeyDTO {
	
	private String id;
	private int productNo;
	private String ip;
	
	
	public LikeyDTO() {
		
	}
	
	public LikeyDTO(String id, int productNo, String ip) {
		super();
		this.id = id;
		this.productNo = productNo;
		this.ip = ip;
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getProductcNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}	
}
