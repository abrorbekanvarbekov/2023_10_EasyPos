package com.example.easypos.Services;

import com.example.easypos.DAO.TableDao;
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

    public ProductType getProductTypeById(int id) {
        return tableDao.getProductTypeById(id);
    }
}
