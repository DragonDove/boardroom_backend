package top.dragondove.boardroom.service;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.dragondove.boardroom.component.GlobalConfiguration;
import top.dragondove.boardroom.entity.Meeting;
import top.dragondove.boardroom.entity.Role;
import top.dragondove.boardroom.entity.User;
import top.dragondove.boardroom.entity.UserMeeting;
import top.dragondove.boardroom.repository.UserRepository;
import top.dragondove.boardroom.util.UpdateUtils;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final GlobalConfiguration configuration;

    @Resource
    private RoleService roleService;

    @Autowired
    public UserService(UserRepository userRepository, GlobalConfiguration configuration) {
        this.userRepository = userRepository;
        this.configuration = configuration;
    }

    public Page<User> getAllUsers(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return userRepository.findAll(pageable);
    }

    public List<User> findUsers(User user) {
        Example<User> example = Example.of(user);
        return userRepository.findAll(example);
    }

    public User findUser(User user) {
        Example<User> example = Example.of(user);
        return userRepository.findOne(example).orElse(null);
    }

    public User getCurrentUser() {
        return (User) SecurityUtils.getSubject().getPrincipal();
    }

    public void saveUser(User user) {
        if (null != user.getId()) {
            User origin = getUserById(user.getId());
            if (null != origin) {
                UpdateUtils.copyNullProperties(origin, user);
            }
        }
        userRepository.save(user);
        if (null == user.getRoles()) {
            userRepository.setBaseRole(user.getId());
        }
    }

    public void deleteUser(User user) {
        userRepository.delete(user);
    }

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public void deleteUserById(Long id) {
        userRepository.deleteById(id);
    }

    public List<Meeting> getLeadMeetingsById(Long id) {
        return userRepository.findById(id).map(User::getLeadMeetings).orElse(Collections.emptyList());
    }

    public List<Meeting> getMeetingsByUserId(Long id) {
        return userRepository.findById(id).map(User::getUserMeetings).orElse(new ArrayList<>()).stream()
                .map(UserMeeting::getMeeting).collect(Collectors.toList());
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public void saveUserPhoto(Long id, MultipartFile file) throws IOException {
        User user = getUserById(id);
        String fileName =file.getOriginalFilename();
        String partialPath = null;
        if (fileName != null) {
            partialPath = "userPhoto/" + user.getId().toString() +
                    fileName.substring(fileName.indexOf('.'));
        }
        if (null == user.getPhotoPath() || !user.getPhotoPath().equals(partialPath)) {
            user.setPhotoPath(partialPath);
            saveUser(user);
        }
        String path = configuration.getFileBasePath() + user.getPhotoPath();
        InputStream is = file.getInputStream();
        File outFile = new File(path);
        outFile.getParentFile().mkdirs();
        Files.copy(is, outFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
    }

    public void saveUserPhoto(MultipartFile file) throws IOException {
        String fileName = file.getOriginalFilename();
        System.out.println(file.getOriginalFilename());
        Long id = Long.parseLong(fileName.replace(".jpg", "").replace(".png", ""));
        saveUserPhoto(id, file);
    }

    public void saveUserPhotos(MultipartFile[] files) throws IOException {
        for (MultipartFile file : files) {
            saveUserPhoto(file);
        }
    }

    public void saveUserRoles(Long id, List<Role> roles) {
        userRepository.removeRolesById(id);
        roles.forEach(role -> userRepository.addRole(id, role.getId()));
    }
}
