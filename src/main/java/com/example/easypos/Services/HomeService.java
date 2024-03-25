package com.example.easypos.Services;

import com.example.easypos.DAO.HomeDao;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Table;
import com.example.easypos.Vo.TableGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HomeService {
    private HomeDao homeDao;
    @Autowired
    public HomeService(HomeDao homeDao) {
        this.homeDao = homeDao;
    }

    public List<CartItems> getCartItems(int floor) {
        return homeDao.getCartItems(floor);
    }

    public List<Table> getTableLIst(int floor) {
        return homeDao.getTableList(floor);
    }

    public List<CartItems> getPriceSumList(int floor) {
        return homeDao.getPriceSumList(floor);
    }

    public List<TableGroup> getTableGroups() {
        return homeDao.getTableGroups();
    }

    public List<CartItems> getOrderTablesList(int i) {
        return homeDao.getOrderTablesList(i);
    }

    // ==============================================================//

    public void updateTablePos(int elPosX, int elPosY, int number, int floor) {
        homeDao.updateTablePos(elPosX, elPosY, number, floor);
    }

    // ==============================================================//

    public List<Integer> getPayedTotalAmount(String floor, String beginDate, String endDate) {
        return homeDao.getPayedTotalAmount(floor, beginDate, endDate);
    }

    public List<Integer> getPayedTotalCnt(String floor, String beginDate, String endDate) {
        return homeDao.getPayedTotalCnt(floor, beginDate, endDate);
    }

    public List<Integer> getPayedTotalDiscountAmount(String floor, String beginDate, String endDate) {
        return homeDao.getPayedTotalDiscountAmount(floor, beginDate, endDate);
    }

    public int getOutstandingAmount(String floor, String beginDate, String endDate) {
        return homeDao.getOutstandingAmount(floor, beginDate, endDate);
    }

    public List<Integer> getNumberOfReturns(String floor, String beginDate, String endDate) {
        return homeDao.getNumberOfReturns(floor, beginDate, endDate);
    }

    public List<Integer> getAmountOfReturns(String floor, String beginDate, String endDate) {
        return homeDao.getAmountOfReturns(floor, beginDate, endDate);
    }

    public int getOutstandingTables(String floor) {
        return homeDao.getOutstandingTables(floor);
    }
    // ==============================================================//

    public List<CartItems> getCurrCartItem(int currTableNum, int floor) {
        return homeDao.getCurrCartItem(currTableNum, floor);
    }

    public void removeCart(int floor, int tabId) {
        homeDao.removeCart(floor, tabId);
    }

    public Cart getCart(int floor, int tabId) {
        return homeDao.getCart(floor, tabId);
    }

    public CartItems getCartItem(int productId, int tabId, int floor) {
        return homeDao.getCartItem(productId, tabId, floor);
    }

    public void toMoveCartItems(int product_id, String productName, int table_id, int quantity, int productPrice,
                                int productSumPrice, int productSailPrice, int floor_id, int cart_id) {
        homeDao.toMoveCartItems(product_id, productName, table_id, quantity, productPrice,productSumPrice,productSailPrice,floor_id,cart_id);
    }

    public void toMoveUpdateCartItems(int afterTableNum, int floor, int productId, int quantity, int productSailPrice, int productSumPrice, int cart_id) {
        homeDao.toMoveUpdateCartItems(afterTableNum, floor, productId, quantity, productSailPrice, productSumPrice, cart_id);
    }

    public void updateCart(int floor, int afterTableNum, int currTableNum) {
        homeDao.updateCart(floor, afterTableNum, currTableNum);
    }

    public void delBeforeCartItem(int currTableNum, int floor) {
        homeDao.delBeforeCartItem(currTableNum, floor);
    }

    // ==============================================================//

    public void addTableGroup(String color) {
        homeDao.addTableGroup(color);
    }

    public void removeTableGroup(int groupId) {
        homeDao.removeTableGroup(groupId);
    }

    public void truncateForTableGroups() {
        homeDao.truncateForTableGroups();
    }

    public void updateTableGroup(int groupId) {
        homeDao.updateTableGroup(groupId);
    }

    public TableGroup getTableGroupById(int groupId) {
        return homeDao.getTableGroupById(groupId);
    }

    // ==============================================================//

    public List<CartItems> getCartItemsList(int tableId, int floor) {
        return homeDao.getCartItemsList(tableId, floor);
    }

}
