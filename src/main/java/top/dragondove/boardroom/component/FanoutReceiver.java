package top.dragondove.boardroom.component;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;
import top.dragondove.boardroom.config.RabbitConfig;
import top.dragondove.boardroom.entity.User;

@Component
public class FanoutReceiver {

    @RabbitListener(queues = RabbitConfig.FANOUT_QUEUE1)
    public void receiveTopic1(User user) {
        System.out.println("[receiverFanout1监听消息" + user);
    }

    @RabbitListener(queues = RabbitConfig.FANOUT_QUEUE2)
    public void receiveTopic2(User user) {
        System.out.println("[receiverFanout2监听消息" + user);
    }

}
