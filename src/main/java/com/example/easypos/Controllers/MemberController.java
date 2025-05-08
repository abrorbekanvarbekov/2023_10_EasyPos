package com.example.easypos.Controllers;

import com.example.easypos.Services.HomeMainService;
import com.example.easypos.Services.MemberService;
import com.example.easypos.Util.Util;
import com.example.easypos.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;


@Controller
public class MemberController {
    private MemberService memberService;
    private HomeMainService homeMainService;
    private Rq rq;
    private LocalTime now;
    private Date dateNow;
    private DateTimeFormatter formatter;
    private SimpleDateFormat dateFormatter;

    @Autowired
    public MemberController(MemberService memberService, Rq rq, HomeMainService homeMainService) {
        this.memberService = memberService;
        this.homeMainService = homeMainService;
        this.rq = rq;
        this.now = LocalTime.now();
        this.dateNow = new Date();


        this.formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
    }

    @RequestMapping("/usr/member/loginPage")
    public String loginPage() {
        rq.logout();
        return "/usr/member/loginPage";
    }

    @RequestMapping("/usr/member/doLogin")
    @ResponseBody
    public ResultDate<String> doLogin(String loginId, String loginPw, boolean isIdSave) {
        String errorMsg = "";

        if (Util.empty(loginId)) {
            errorMsg = "로그인 아이디를 입력해주세요";
            return ResultDate.from("F-1", errorMsg);
        }

        if (Util.empty(loginPw)) {
            errorMsg = "로그인 비밀번호를 입력해주세요";
            return ResultDate.from("F-1", errorMsg);
        }

        Members member = memberService.doLogin(loginId);
        if (member == null) {
            errorMsg = String.format("%s 이라는 아이디가 존재하지 않습니다.", loginId);
            return ResultDate.from("F-1", errorMsg);
        }

        if (member.getLoginPw().equals(loginPw) == false) {
            errorMsg = "비밀번호가 일치하지 않습니다.";
            return ResultDate.from("F-1", errorMsg);
        }

        if (member.getDelStatus() == 1) {
            errorMsg = "삭제 된 계정으로 로그인 할수 없습니다";
            return ResultDate.from("F-1", errorMsg);
        }

//        if (rq.getLoginedMemberId() != 0) {
//            errorMsg = "이미 로그인 상태 입니다.";
//            return ResultDate.from("S-2", errorMsg, "homeUrl", "/?floor=1");
//        }
// asdasdasdasdasdasdsd
        rq.login(member);
        if (rq.getLoginedEmployee() == null) {
            return ResultDate.from("S-1", "/usr/member/employeeListPage");
        } else {
            return ResultDate.from("S-1", "/");
        }
    }

    @RequestMapping("/usr/member/employeeListPage")
    public String employeeListPage(Model model) {

        List<Employee> employeeList = memberService.getEmployeeList();

        String todayDate = dateFormatter.format(dateNow);
        model.addAttribute("todayDate", todayDate);

        if (employeeList.size() != 0) {
            model.addAttribute("employeeList", employeeList);
        }
        return "/usr/member/employeeListPage";
    }

    @RequestMapping("/usr/member/doLoginEmployee")
    @ResponseBody
    public ResultDate getEmployee(int employeeCode, String employeePw, String openingDate) {

        Employee employee = memberService.getEmployee(employeeCode);

        String errorMsg = "";

        if (Util.empty(employeePw)) {
            errorMsg = "사원비밀번호를 입력해주세요.";
            return ResultDate.from("F-1", errorMsg);
        }

        if (employee == null) {
            errorMsg = "입력하신 사원코드가 존재하지 않습니다.";
            return ResultDate.from("F-1", errorMsg);
        }

        if (employee.getEmployeePw().equals(Util.sha256(employeePw)) == false) {
            errorMsg = "사원 비밀번호가 일치하지 않습니다.";
            return ResultDate.from("F-1", errorMsg);
        }

        rq.loginEmployee(employee);

        String currentTime = formatter.format(now);

        if (openingDate.length() != 0) {
            rq.setBusinessDate(openingDate + " " + currentTime);
        }
        return ResultDate.from("S-1", "/?floor=1");
    }

}
