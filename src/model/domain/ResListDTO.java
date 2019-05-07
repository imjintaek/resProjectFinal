package model.domain;

public class ResListDTO {
	private String resName;
	private double resLat;
	private double resLng;
	private String resAddress;
	public ResListDTO() {
	}
	public ResListDTO(String resName, double resLat, double resLng, String resAddress) {
		super();
		this.resName = resName;
		this.resLat = resLat;
		this.resLng = resLng;
		this.resAddress = resAddress;
	}
	public String getResName() {
		return resName;
	}
	public void setResName(String resName) {
		this.resName = resName;
	}
	public double getResLat() {
		return resLat;
	}
	public void setResLat(int resLat) {
		this.resLat = resLat;
	}
	public double getResLng() {
		return resLng;
	}
	public void setResLng(int resLng) {
		this.resLng = resLng;
	}
	public String getResAddress() {
		return resAddress;
	}
	public void setResAddress(String resAddress) {
		this.resAddress = resAddress;
	}
	@Override
	public String toString() {
		return "ResListDTO [resName=" + resName + ", resLat=" + resLat + ", resLng=" + resLng + ", resAddress="
				+ resAddress + "]";
	}
}
