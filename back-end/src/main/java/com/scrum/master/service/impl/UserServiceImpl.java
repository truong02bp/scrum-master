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
//            "V???i user, t??i mu???n hi???n th??? d??? li???u t??? Apple Search Ads tr??n App dashboard",
//            "V???i admin, t??i mu???n x??y d???ng ch???c n??ng connect t???i c??c Mediation Service",
//            "V???i admin, t??i mu???n x??y d???ng ch???c n??ng connect t???i AppsFlyer",
//            "V???i user, t??i mu???n hi???n th??? d??? li???u t??? c??c m???ng tr??n App dashboard",
//            "V???i user, hi???n th??? d??? li???u t??? Unity tr??n App dashboard",
//            "V???i user, t??i mu???n x??y d???ng giao di???n App dashboard",
//            "V???i user, t??i mu???n hi???n th??? d??? li???u t??? Google Ads tr??n App dashboard",
//            "V???i user, t??i mu???n hi???n th??? d??? li???u t??? Iron Source tr??n App dashboard",
//            "Qu???n l?? static icon, image",
//            "V???i user, t??i mu???n hi???n th??? d??? li???u t??? Apple Search Ads tr??n App dashboard",
//            "Vi???t api tr??? d??? li???u dashboard",
//            "D???ng base job collector l???y d??? li???u t??? network",
//            "L???y raw data t??? network",
//            "Vi???t api tr??? d??? li???u dashboard",
//            "L???y data raw t??? Unity Ads network",
//            "Vi???t api tr??? d??? li???u dashboard",
//            "K???t n???i v???i Facebook Ads",
//            "Custom sidebar cho qu???n l?? app, x??? l?? activedTab khi user copy/paste ???????ng d???n",
//            "K???t n???i v???i network Vungle, LiftOff",
//            "K???t n???i v???i Tapjoy",
//            "K???t n???i v???i Big Query",
//            "K???t n???i v???i IronSource Mediation",
//            "K???t n???i v???i FirseBase Ad Revenue",
//            "K???t n???i v???i Max Mediation",
//            "Th??m c??c bi???u ????? barChart cho Cost, Installs",
//            "Th??m c??c table hi???n th??? th??ng tin (Campain, Ad, Asset, Site ID Performance,... )",
//            "Th??m bi???u ????? Installs theo ?????a l??",
//            "Add Summary stats (Overview) cho ?????u trang g???m ch??? s??? v?? c??c line chart",
//            "X??? l?? filter (?????u trang) theo date, country, networkType...",
//            "V???i user, t??i mu???n c?? ch???c n??ng xem chi ti???t c??c Campaign c???a App tr??n Mintegral",
//            "V???i user, t??i mu???n l???y c??c th??ng s??? app, campaign, bid, budget v?? ch???nh s???a t??? c??c m???ng",
//            "X??y d???ng ch???c n??ng logging v???i ELK",
//            "K???t n???i api Data Connector c???a Facebook Ads, Vungle, Apple Search Ads...",
//            "S???a config kafka",
//            "X??y d???ng job collector ?????ng b??? d??? li???u app, campaign t??? network",
//            "S???a logic business cho ph???n Data Connector",
//            "X??y d???ng connector cho AppsFlyer",
//            "Custom search column in tables",
//            "BA task: Ph??n t??ch y??u c???u app - ch???p ???nh giao di???n c???a web: Cost center",
//            "Custom dashboard theo d???ng bi???u ?????",
//            "Gh??p api d??? li???u tr??n App dashboard",
//            "K???t n???i connector Facebook Ads",
//            "K???t n???i connector Vungle",
//            "K???t n???i connector Apple Search Ads",
//            "V???i user, t??i mu???n ch???c n??ng xu???t b??o c??o ch??? s??? campaign",
//            "V???i user, t??i mu???n ch???c n??ng s???a bid, budget ngay tr??n b??o c??o campaign cho Mintegral",
//            "V???i user, t??i mu???n ch???c n??ng thay ?????i bid theo c??ng th???c Bid d???a tr??n nhi???u ti??u ch??, ??i???u ki???n",
//            "V???i user, t??i mu???n ch???c n??ng t???o c??c c??ng th???c Bid c?? nhi???u ti??u ch??, ??i???u ki???n",
//            "V???i user, t??i mu???n ch???c n??ng t???o campaign theo template",
//            "V???i user, t??i mu???n ch???c n??ng upload creative",
//            "V???i user, t??i mu???n ch???c n??ng t???o template cho c??c Campaign",
//            "V???i user, t??i mu???n c?? ch???c n??ng ch???nh s???a bid",
//            "L???y app, campaign, bid, budget tr??n m???ng Mintegral",
//            "S???a logic l??u app xu???ng data theo nhi???u connector",
//            "V???i user t??i mu???n hi???n th??? b???ng level app, campaign v???i c??c m???c bid, budget, install, cost, impression",
//            "V???i user, t??i mu???n hi???n th??? ch???c n??ng l???p l???ch thay ?????i bid",
//            "V???i user, t??i mu???n ch???c n??ng upload file csv bid cho Mintegral",
//            "L???y raw data t??? Unity Ads network",
//            "L???y raw data t??? IronSource Ads network",
//            "L???y raw data t??? Applovin network",
//            "L???y raw data t??? Tiktok Ads network",
//            "L???y raw data t??? Apple search ads network",
//            "L???y raw data t??? Vungle network",
//            "L???y raw data t??? Mintegral network",
//            "T???o c?? ch??? l??u data t??? temp sang final",
//            "L???y raw data t??? Facebook Ads network",
//            "D???ng producer cho t???t c??? c??c network",
//            "L???y raw data t??? Google Ads network",
//            "X??y d???ng UI cho Campaign Center page",
//            "T???o b??? filter ?????u trang",
//            "Hi???n th??? table level app, campaign",
//            "L???y app, campaign, bid, budget tr??n m???ng Google Ads",
//            "X??y d???ng API xu???t b??o c??o campaign",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Applovin",
//            "S???a logic l??u defaultBid, default budget c???a Campaign",
//            "Thay ?????i logic link app, remove link app",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n IronSource",
//            "Gh??p API report cho Campaign Center",
//            "X??y d???ng giao di???n cho ch???c n??ng s???a bid h??ng lo???t theo Campaign, Network, Country",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Unity",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Vungle",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Tiktok Ads",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Apple Search",
//            "L???y d??? li???u c???u h??nh v?? ch???nh s???a bid,app tr??n Facebook Ads",
//            "S???a collection name c???a report v2",
//            "X??y d???ng API s???a bid, budget h??ng lo???t theo Country, Network, Campaign",
//            "S???a Api l???y cost report",
//            "Update exception, update param g???i sang API Report",
//            "S???a logic l???y budget default",
//            "S???a logic l???y bid, budget tr??n Mintegral",
//            "D???ng base service ua-report",
//            "T??ch code t??? service crawl data",
//            "Qu???n l?? Bid, Budget Tiktok Ad theo Ad Group",
//            "Th??m adGroup v??o trong Tiktok report v?? Apple search",
//            "T???i ??u ch???c n??ng s???a budget, bid, report",
//            "Th??m sleep gi???a c??c request c???a Unity",
//            "X??y d???ng trang batch history, bid history, budget history",
//            "C???i thi???n performance UI/UX",
//            "T???i ??u filter cho campaign center report",
//            "X??y d???ng ch???c n??ng th??ng b??o activity qua skype",
//            "Ho??n thi???n l???y report cho Facebook Ads",
//            "T???i ??u service falcon-ua-data",
//            "X??y d???ng API xem bid history, budget history",
//            "X??y d???ng API s???a bid theo Network, Country, Campaign",
//            "X??y d???ng API s???a budget theo Network, Country, Campaign",
//            "T???o c??c API l???y report",
//            "T???i ??u d??? li???u trong db",
//            "Th??m c??c ch??? s??? eCpm, eCpc, ctr, oCvr, cvr, eCpi trong API l???y report theo campaign",
//            "T???o l???ch l???y currencym???i l???n 1 ng??y",
//            "Update th??m c??c tr?????ng th??ng tin cho report",
//            "API cost overview c??c ch??? s??? theo kho???ng th???i gian c???a app",
//            "Th??m filter Adgroup, Keyword",
//            "API l???y th??ng tin trend-chart",
//            "X??? l?? b???t ?????ng b??? cho ch???c n??ng Batch edit",
//            "L???y th??m d??? li???u v??? creative c???a c??c network: Google, AppleSearch, Applovin",
//            "L???y d??? th??m d??? li???u v??? creative",
//            "X??y d???ng giao di???n clone, k??o th??? chart",
//            "X??y d???ng API table report tr??n trang overview",
//            "Check d??? li???u report Mintegral, Facebook, Google",
//            "X??y d???ng ch???c n??ng th??ng b??o activity t???i Telegram",
//            "S???a query data c???a Google-ads trong campaign report",
//            "API get breakdown table filter",
//            "API l???y th??ng tin data c???a Breakdown table",
//            "Th??m filter network, country cho batch history",
//            "K???t n???i v?? l???y d??? li???u c???u h??nh network Moloco",
//            "Api l???y th??ng tin v??? cost cho list app",
//            "Chuy???n d??? li???u sang final",
//            "X??y d???ng ch???c n??ng t???o group Telegram v???i Chat Bot",
//            "th??m filter query cho API report"
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
