package top.dragondove.boardroom.config;

import com.jagregory.shiro.freemarker.ShiroTags;
import freemarker.template.TemplateException;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.io.IOException;

@Configuration
public class MyFreeMarkerConfig {

    @Bean
    public FreeMarkerConfigurer freeMarkerConfigurer() throws IOException, TemplateException {
        FreeMarkerConfigurer configurer = new FreeMarkerConfigurer();
        configurer.setTemplateLoaderPath("classpath:templates/");
        freemarker.template.Configuration configuration = configurer.createConfiguration();
        configuration.setDefaultEncoding("UTF-8");
        configuration.setSharedVariable("shiro", new ShiroTags());
        configurer.setConfiguration(configuration);
        return configurer;
    }

}
