package com.example.easypos.Services;

import com.example.easypos.DAO.TableDao;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Product;
import com.example.easypos.Vo.ProductType;
import com.example.easypos.Vo.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {
    private TableDao tableDao;

    @Autowired

    public TableService(TableDao tableDao) {
        this.tableDao = tableDao;
    }

    public List<Table> getTableLIst(int floor) {
        return tableDao.getTableList(floor);
    }

    public void updateTablePos(int elPosX, int elPosY, int id) {
        tableDao.updateTablePos(elPosX, elPosY, id);
    }

    public List<ProductType> getProductTypes() {
        return tableDao.getProductTypes();
    }

    public Product getProductById(int id) {
        return tableDao.getProductById(id);
    }

    public List<Product> getProductList() {
        return tableDao.getProductList();
    }

    public void insertCartItems(int id, int tabId, int floor_id) {
        tableDao.insertCartItems(id, tabId, floor_id);
    }

    public List<CartItems> getCartItemsList(int tableId, int floor) {
        return tableDao.getCartItemsList(tableId, floor);
    }

    public CartItems getCartItem(int productId, int tabId, int floor) {
        return tableDao.getCartItem(productId, tabId, floor);
    }

    public int updateCartItems(int id, int tabId, int floor) {
//        tableDao.updateCartItems(id, tabId, floor);
        return tableDao.updateCartItems(id, tabId, floor);
    }

    public List<CartItems> getCartItems(int floor) {
        return tableDao.getCartItems(floor);
    }

    public List<CartItems> getPriceSumList(int floor) {
        return tableDao.getPriceSumList(floor);
    }

    public int getTotalQuantity(int tabId, int floor) {
        return tableDao.getTotalQuantity(tabId, floor);
    }

    public int getTotalSumPrice(int tabId, int floor) {
        return tableDao.getTotalSumPrice(tabId, floor);
    }

    public void cancelProduct(int productId, int tabId, int floor) {
        tableDao.cancelProduct(productId, tabId, floor);
    }
}
