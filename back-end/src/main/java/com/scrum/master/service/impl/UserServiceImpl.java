package com.scrum.master.service.impl;

import com.scrum.master.common.enums.IssueStatus;
import com.scrum.master.common.enums.IssueType;
import com.scrum.master.common.exceptions.*;
import com.scrum.master.common.utils.SecurityUtils;
import com.scrum.master.common.utils.Validator;
import com.scrum.master.data.dto.ActiveUserRequest;
import com.scrum.master.data.dto.MediaDto;
import com.scrum.master.data.dto.MyUserDetails;
import com.scrum.master.data.dto.UserDto;
import com.scrum.master.data.entities.*;
import com.scrum.master.data.repositories.*;
import com.scrum.master.service.IssueService;
import com.scrum.master.service.MailService;
import com.scrum.master.service.MinioService;
import com.scrum.master.service.UserService;
import com.sun.xml.bind.v2.TODO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.lang.reflect.Member;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MailService mailService;
    private final MinioService minioService;
    private final IssueService issueService;
    private final IssueRepository issueRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email).orElseThrow(() -> {
            throw new UsernameNotFoundException("Not found email : " + email);
        });
        List<GrantedAuthority> authorities = new ArrayList<>() {{
            add(new SimpleGrantedAuthority("ROLE_" + user.getRole().getCode()));
        }};
        return new MyUserDetails(user.getEmail(), user.getPassword(), true, true, true, true, authorities, user);
    }

    @Override
    public User update(UserDto userDto) {
        User user = findById(userDto.getId());
        user.setName(userDto.getName());
        user.setAddress(userDto.getAddress());
        user.setPhone(userDto.getPhone());
        List<Byte> bytes = userDto.getBytes();
        if (bytes != null && !bytes.isEmpty()) {
            final String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
            Byte[] arrays = bytes.toArray(new Byte[bytes.size()]);
            minioService.upload("/" + time + "/", user.getId() + ".png",
                new ByteArrayInputStream(ArrayUtils.toPrimitive(arrays)));
            user.setAvatarUrl("/" + time + "/" + user.getId() + ".png");
        }

        return userRepository.save(user);
    }

    @Override
    public User updatePassword(UserDto userDto) {
        User user = findById(userDto.getId());
        if (!bCryptPasswordEncoder.matches(userDto.getOldPassword(), user.getPassword())) {
            throw BusinessException.builder().status(HttpStatus.INTERNAL_SERVER_ERROR).message("Old password don't match").build();
        }
        user.setPassword(bCryptPasswordEncoder.encode(userDto.getNewPassword()));
        return userRepository.save(user);
    }

    @Override
    public User updateAvatar(MediaDto mediaDto) {
        if (mediaDto.getBytes() == null) {
            throw BusinessException.builder().status(HttpStatus.BAD_REQUEST).message("Bytes media must not be empty").build();
        }

        final String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
        String folder = "/" + time + "/";
        minioService.upload(folder, mediaDto.getName(), new ByteArrayInputStream(mediaDto.getBytes()));
        String url = folder + mediaDto.getName();
        User user = SecurityUtils.getCurrentUser();
        user.setAvatarUrl(url);
        return userRepository.save(user);
    }

    @Override
    public void delete(Long id) {
        User user = userRepository.findById(id).orElse(new User());
        user.setActive(false);
        userRepository.save(user);
    }

    @Override
    public List<User> findAll() {
        Organization organization = SecurityUtils.getCurrentOrganization();
        return userRepository.findByOrganization(organization.getId());
    }

    @Override
    public void generateData() {
//        List<String> values = List.of(
//            "Với user, tôi muốn hiển thị dữ liệu từ Apple Search Ads trên App dashboard",
//            "Với admin, tôi muốn xây dựng chức năng connect tới các Mediation Service",
//            "Với admin, tôi muốn xây dựng chức năng connect tới AppsFlyer",
//            "Với user, tôi muốn hiển thị dữ liệu từ các mạng trên App dashboard",
//            "Với user, hiển thị dữ liệu từ Unity trên App dashboard",
//            "Với user, tôi muốn xây dựng giao diện App dashboard",
//            "Với user, tôi muốn hiển thị dữ liệu từ Google Ads trên App dashboard",
//            "Với user, tôi muốn hiển thị dữ liệu từ Iron Source trên App dashboard",
//            "Quản lý static icon, image",
//            "Với user, tôi muốn hiển thị dữ liệu từ Apple Search Ads trên App dashboard",
//            "Viết api trả dữ liệu dashboard",
//            "Dựng base job collector lấy dữ liệu từ network",
//            "Lấy raw data từ network",
//            "Viết api trả dữ liệu dashboard",
//            "Lấy data raw từ Unity Ads network",
//            "Viết api trả dữ liệu dashboard",
//            "Kết nối với Facebook Ads",
//            "Custom sidebar cho quản lý app, xử lý activedTab khi user copy/paste đường dẫn",
//            "Kết nối với network Vungle, LiftOff",
//            "Kết nối với Tapjoy",
//            "Kết nối với Big Query",
//            "Kết nối với IronSource Mediation",
//            "Kết nối với FirseBase Ad Revenue",
//            "Kết nối với Max Mediation",
//            "Thêm các biểu đồ barChart cho Cost, Installs",
//            "Thêm các table hiển thị thông tin (Campain, Ad, Asset, Site ID Performance,... )",
//            "Thêm biểu đồ Installs theo địa lý",
//            "Add Summary stats (Overview) cho đầu trang gồm chỉ số và các line chart",
//            "Xử lý filter (đầu trang) theo date, country, networkType...",
//            "Với user, tôi muốn có chức năng xem chi tiết các Campaign của App trên Mintegral",
//            "Với user, tôi muốn lấy các thông số app, campaign, bid, budget và chỉnh sửa từ các mạng",
//            "Xây dựng chức năng logging với ELK",
//            "Kết nối api Data Connector của Facebook Ads, Vungle, Apple Search Ads...",
//            "Sửa config kafka",
//            "Xây dựng job collector đồng bộ dữ liệu app, campaign từ network",
//            "Sửa logic business cho phần Data Connector",
//            "Xây dựng connector cho AppsFlyer",
//            "Custom search column in tables",
//            "BA task: Phân tích yêu cầu app - chụp ảnh giao diện của web: Cost center",
//            "Custom dashboard theo dạng biểu đồ",
//            "Ghép api dữ liệu trên App dashboard",
//            "Kết nối connector Facebook Ads",
//            "Kết nối connector Vungle",
//            "Kết nối connector Apple Search Ads",
//            "Với user, tôi muốn chức năng xuất báo cáo chỉ số campaign",
//            "Với user, tôi muốn chức năng sửa bid, budget ngay trên báo cáo campaign cho Mintegral",
//            "Với user, tôi muốn chức năng thay đổi bid theo công thức Bid dựa trên nhiều tiêu chí, điều kiện",
//            "Với user, tôi muốn chức năng tạo các công thức Bid có nhiều tiêu chí, điều kiện",
//            "Với user, tôi muốn chức năng tạo campaign theo template",
//            "Với user, tôi muốn chức năng upload creative",
//            "Với user, tôi muốn chức năng tạo template cho các Campaign",
//            "Với user, tôi muốn có chức năng chỉnh sửa bid",
//            "Lấy app, campaign, bid, budget trên mạng Mintegral",
//            "Sửa logic lưu app xuống data theo nhiều connector",
//            "Với user tôi muốn hiển thị bảng level app, campaign với các mục bid, budget, install, cost, impression",
//            "Với user, tôi muốn hiển thị chức năng lập lịch thay đổi bid",
//            "Với user, tôi muốn chức năng upload file csv bid cho Mintegral",
//            "Lấy raw data từ Unity Ads network",
//            "Lấy raw data từ IronSource Ads network",
//            "Lấy raw data từ Applovin network",
//            "Lấy raw data từ Tiktok Ads network",
//            "Lấy raw data từ Apple search ads network",
//            "Lấy raw data từ Vungle network",
//            "Lấy raw data từ Mintegral network",
//            "Tạo cơ chế lưu data từ temp sang final",
//            "Lấy raw data từ Facebook Ads network",
//            "Dựng producer cho tất cả các network",
//            "Lấy raw data từ Google Ads network",
//            "Xây dựng UI cho Campaign Center page",
//            "Tạo bộ filter đầu trang",
//            "Hiển thị table level app, campaign",
//            "Lấy app, campaign, bid, budget trên mạng Google Ads",
//            "Xây dựng API xuất báo cáo campaign",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Applovin",
//            "Sửa logic lưu defaultBid, default budget của Campaign",
//            "Thay đổi logic link app, remove link app",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên IronSource",
//            "Ghép API report cho Campaign Center",
//            "Xây dựng giao diện cho chức năng sửa bid hàng loạt theo Campaign, Network, Country",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Unity",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Vungle",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Tiktok Ads",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Apple Search",
//            "Lấy dữ liệu cấu hình và chỉnh sửa bid,app trên Facebook Ads",
//            "Sửa collection name của report v2",
//            "Xây dựng API sửa bid, budget hàng loạt theo Country, Network, Campaign",
//            "Sửa Api lấy cost report",
//            "Update exception, update param gửi sang API Report",
//            "Sửa logic lấy budget default",
//            "Sửa logic lấy bid, budget trên Mintegral",
//            "Dựng base service ua-report",
//            "Tách code từ service crawl data",
//            "Quản lý Bid, Budget Tiktok Ad theo Ad Group",
//            "Thêm adGroup vào trong Tiktok report và Apple search",
//            "Tối ưu chức năng sửa budget, bid, report",
//            "Thêm sleep giữa các request của Unity",
//            "Xây dựng trang batch history, bid history, budget history",
//            "Cải thiện performance UI/UX",
//            "Tối ưu filter cho campaign center report",
//            "Xây dựng chức năng thông báo activity qua skype",
//            "Hoàn thiện lấy report cho Facebook Ads",
//            "Tối ưu service falcon-ua-data",
//            "Xây dựng API xem bid history, budget history",
//            "Xây dựng API sửa bid theo Network, Country, Campaign",
//            "Xây dựng API sửa budget theo Network, Country, Campaign",
//            "Tạo các API lấy report",
//            "Tối ưu dữ liệu trong db",
//            "Thêm các chỉ số eCpm, eCpc, ctr, oCvr, cvr, eCpi trong API lấy report theo campaign",
//            "Tạo lịch lấy currencymỗi lần 1 ngày",
//            "Update thêm các trường thông tin cho report",
//            "API cost overview các chỉ số theo khoảng thời gian của app",
//            "Thêm filter Adgroup, Keyword",
//            "API lấy thông tin trend-chart",
//            "Xử lý bất đồng bộ cho chức năng Batch edit",
//            "Lấy thêm dữ liệu về creative của các network: Google, AppleSearch, Applovin",
//            "Lấy dữ thêm dữ liệu về creative",
//            "Xây dựng giao diện clone, kéo thả chart",
//            "Xây dựng API table report trên trang overview",
//            "Check dữ liệu report Mintegral, Facebook, Google",
//            "Xây dựng chức năng thông báo activity tới Telegram",
//            "Sửa query data của Google-ads trong campaign report",
//            "API get breakdown table filter",
//            "API lấy thông tin data của Breakdown table",
//            "Thêm filter network, country cho batch history",
//            "Kết nối và lấy dữ liệu cấu hình network Moloco",
//            "Api lấy thông tin về cost cho list app",
//            "Chuyển dữ liệu sang final",
//            "Xây dựng chức năng tạo group Telegram với Chat Bot",
//            "thêm filter query cho API report"
//        );
//        Random random = new Random();
//        Project project = projectRepository.findById((long) 5).orElse(null);
//        List<ProjectMember> members = project.getMembers();
//        for (int i=0; i < values.size(); i++) {
//            Issue issue = new Issue();
//            issue.setProject(project);
//            if (i%2==0) {
//                issue.setType(IssueType.Story);
//                issue.setEstimate(5);
//                issue.setLabel("Deploy");
//            }
//            else {
//                issue.setType(IssueType.Task);
//                issue.setEstimate(2);
//                issue.setLabel("Operation");
//            }
//            issue.setTitle(values.get(i));
//            issue.setDescription(values.get(i));
//            int index = random.nextInt(0, members.size() -1 );
//            issue.setAssignee(members.get(index).getUser());
//            if (i < 90) {
//                issue.setStatus(IssueStatus.Done);
//            }
//            else {
//                issue.setStatus(IssueStatus.Todo);
//            }
//            if (i < 15) {
//                issue.setSprint(sprintRepository.findById((long) 1).orElse(null));
//            }
//            else {
//                if (i < 30) {
//                    issue.setSprint(sprintRepository.findById((long) 2).orElse(null));
//                }
//                else {
//                    if (i < 50) {
//                        issue.setSprint(sprintRepository.findById((long) 3).orElse(null));
//                    }
//                    else {
//                        if (i < 70) {
//                            issue.setSprint(sprintRepository.findById((long) 4).orElse(null));
//                        }
//                        else {
//                            if (i < 90) {
//                                issue.setSprint(sprintRepository.findById((long) 5).orElse(null));
//                            }
//                        }
//                    }
//                }
//            }
//
//
//            issueService.create(issue);
//        }
        List<Issue> issues = issueRepository.findAll();
        for (Issue issue : issues) {
            Long i = issue.getId();
            User user = new User();
            user.setId((long) 1);
            issue.setReporter(user);
            if (i < 15) {
                issue.setCreatedDate(LocalDateTime.now().minusDays(28));
                issue.setStartDate(LocalDateTime.now().minusDays(27));
                issue.setEndDate(LocalDateTime.now().minusDays(24));
            } else {
                if (i < 30) {
                    issue.setCreatedDate(LocalDateTime.now().minusDays(23));
                    issue.setStartDate(LocalDateTime.now().minusDays(22));
                    issue.setEndDate(LocalDateTime.now().minusDays(20));
                } else {
                    if (i < 50) {
                        issue.setCreatedDate(LocalDateTime.now().minusDays(18));
                        issue.setStartDate(LocalDateTime.now().minusDays(17));
                        issue.setEndDate(LocalDateTime.now().minusDays(13));
                    } else {
                        if (i < 70) {
                            issue.setCreatedDate(LocalDateTime.now().minusDays(12));
                            issue.setStartDate(LocalDateTime.now().minusDays(11));
                            issue.setEndDate(LocalDateTime.now().minusDays(7));
                        } else {
                            if (i < 90) {
                                issue.setCreatedDate(LocalDateTime.now().minusDays(6));
                                issue.setStartDate(LocalDateTime.now().minusDays(5));
                                issue.setEndDate(LocalDateTime.now().minusDays(1));
                            }
                        }
                    }
                }
            }
        }
        issueRepository.saveAll(issues);
    }

    public User findById(Long id) {
        return userRepository.findById(id).orElseThrow(() -> {
            throw BusinessException.builder().message("User not found with id {" + id + "}").status(HttpStatus.NOT_FOUND).build();
        });
    }

    @Override
    public User create(User user) {
        String email = user.getEmail();
        if (!Validator.isValidEmail(email) || user.getRole() == null) {
            throw new UserRegisterInvalidException();
        }
        User existedUser = userRepository.findByEmail(email).orElse(null);
        if (existedUser != null && existedUser.isActive()) {
            throw new UserExistedException(email);
        }
        // send email active user
        mailService.sendActiveUserMail(email);
        if (existedUser != null) {
            return existedUser;
        }
        user.setOrganization(SecurityUtils.getCurrentOrganization());
        user.setAvatarUrl("/anonymous.png");
        return userRepository.save(user);
    }

    @Override
    public User activeUser(ActiveUserRequest activeUserRequest) {
        String email = activeUserRequest.getEmail();
        if (StringUtils.isBlank(email)) {
            throw new ActiveUserInvalidException();
        }
        User user = userRepository.findInactiveUserByEmail(email).orElseThrow(() -> {
            throw new UserNotFoundException(email);
        });
        user.setActive(true);
        // user yet active by email
        if (user.getPassword() == null) {
            String password = activeUserRequest.getPassword();
            String name = activeUserRequest.getName();
            if (StringUtils.isBlank(password) || StringUtils.isBlank(name)) {
                throw new ActiveUserInvalidException();
            }
            user.setName(name);
            user.setPassword(bCryptPasswordEncoder.encode(password));
        }
        return userRepository.save(user);
    }

}
