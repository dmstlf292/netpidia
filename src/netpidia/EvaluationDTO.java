package netpidia;

public class EvaluationDTO {
	int productNo;
	String id;
	String title;
	String content;
	String totalScore;
	String totalRate;
	String month;
	int likeCount;
	
	
	public EvaluationDTO() {

	}


	public int getProductNo() {
		return productNo;
	}


	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getTotalScore() {
		return totalScore;
	}


	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}


	public String getTotalRate() {
		return totalRate;
	}


	public void setTotalRate(String totalRate) {
		this.totalRate = totalRate;
	}


	public String getMonth() {
		return month;
	}


	public void setMonth(String month) {
		this.month = month;
	}


	public int getLikeCount() {
		return likeCount;
	}


	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}


	public EvaluationDTO(int productNo, String id, String title, String content, String totalScore, String totalRate,
			String month, int likeCount) {
		super();
		this.productNo = productNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.totalScore = totalScore;
		this.totalRate = totalRate;
		this.month = month;
		this.likeCount = likeCount;
	}


	
	
	
	
	
	
	
	
	
	
}
