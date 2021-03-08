package top.dragondove.boardroom.component;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.time.LocalTime;

@Data
@Component
@ConfigurationProperties(prefix = "boardroom.config")
public class GlobalConfiguration {

    private String fileBasePath;

    private Long timeSegment;

    private LocalTime startOfDay;

    private LocalTime endOfDay;

}
