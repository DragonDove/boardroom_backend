package top.dragondove.boardroom.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.dragondove.boardroom.component.GlobalConfiguration;

@Configuration
public class MyWebMvcConfig implements WebMvcConfigurer {

    private final GlobalConfiguration globalConfiguration;

    @Autowired
    public MyWebMvcConfig(GlobalConfiguration globalConfiguration) {
        this.globalConfiguration = globalConfiguration;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/")
                .addResourceLocations("file:" + globalConfiguration.getFileBasePath());

    }
}
