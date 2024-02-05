package com.example.easypos.Services;

import com.example.easypos.DAO.MemberDao;
import com.example.easypos.Vo.Employee;
import com.example.easypos.Vo.Members;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MemberService {
    private MemberDao memberDao;

    @Autowired
    public MemberService(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    public Members getMember(String loginId, String loginPw) {
        return memberDao.getMember(loginId, loginPw);
    }

    public Members doLogin(String loginId) {
        return memberDao.doLogin(loginId);
    }

    public Members getMemberById(int loginedMemberId) {
        return memberDao.getMemberById(loginedMemberId);
    }

    public List<Employee> getEmployeeList(int loginedMemberId) {
        return memberDao.getEmployeeList(loginedMemberId);
    }

    public Employee getEmployee(int employeeCode) {
        return memberDao.getEmployee(employeeCode);
    }
}
