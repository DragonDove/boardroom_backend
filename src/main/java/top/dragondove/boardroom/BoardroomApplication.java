package top.dragondove.boardroom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class BoardroomApplication {

    public static void main(String[] args) {
        SpringApplication.run(BoardroomApplication.class, args);
    }

}

