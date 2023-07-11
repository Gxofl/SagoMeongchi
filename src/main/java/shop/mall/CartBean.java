package shop.mall;

import java.util.Vector;

import shop.ProductBean;
import shop.ProductDAO;

public class CartBean {
	private Vector<ProductBean> clist;
	
	public CartBean() {
		clist = new Vector<ProductBean>();
	}
	
	public void addProduct(String pno, String pqty) {
		
		int pno_new = Integer.parseInt(pno);
		int pqty_new = Integer.parseInt(pqty);
		
		for(int i=0; i<clist.size(); i++) {
			if(pno_new==clist.get(i).getPno()) {
				int pqty_old = clist.get(i).getStock();
				clist.get(i).setStock(pqty_old+pqty_new);
				return;
			}
		}
		
		ProductDAO pdao = ProductDAO.getInstance();
		ProductBean pb = pdao.getProductByPno(pno);
		pb.setStock(pqty_new); // 주문수량으로 넣음
		clist.add(pb);
	}//addProduct
	
	public Vector<ProductBean> getAllproduct(){
		return clist;
	}
	
	public void deleteCart(String pno) {
		for(ProductBean pb : clist) {
			if(Integer.parseInt(pno)==pb.getPno()) {
				clist.removeElement(pb);
				break;
			}
		}//for
	}//deleteCart
	
	public void editPqty(String pno, String pqty_new) {
		for(ProductBean pb : clist) {
			if(Integer.parseInt(pno)==pb.getPno()) {
				if(pqty_new.equals("0")) {
					clist.removeElement(pb);
				}else {
					pb.setStock(Integer.parseInt(pqty_new));
					break;
				}
			}
		}//for
	}//editPqty
	
	public void deleteAllCart() {
		clist.removeAllElements();
	}
	
}
