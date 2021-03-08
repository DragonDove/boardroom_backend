package top.dragondove.boardroom.component;

import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.dragondove.boardroom.config.RabbitConfig;
import top.dragondove.boardroom.entity.User;

@Component
public class FanoutSender {
    private final AmqpTemplate rabbitTemplate;

    @Autowired
    public FanoutSender(AmqpTemplate rabbitTemplate) {
        this.rabbitTemplate = rabbitTemplate;
    }

    public void send(User user) {
        rabbitTemplate.convertAndSend(RabbitConfig.FANOUT_EXCHANGE, "", user);
    }

}
