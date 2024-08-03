CREATE TABLE `t_invite_reward_journal`
(
    `id`                 bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
    `inviter_user_id`    bigint unsigned NOT NULL DEFAULT '0' COMMENT '邀请人',
    `business_id`        varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '业务流水编号',
    `reward_type`        tinyint unsigned NOT NULL DEFAULT '0' COMMENT '1-邀请奖励 2-交易奖励 3-渠道奖励',
    `reward_status`      tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0-未发 1-已发 2-无效',
    `reward_amount`      decimal(38, 18) unsigned NOT NULL DEFAULT '0.000000000000000000' COMMENT '发放奖励金额',
    `usdt_amount`        decimal(38, 18) unsigned NOT NULL COMMENT 'u金额',
    `reward_currency`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL DEFAULT '' COMMENT '发放奖励币种',
    `reward_time`        timestamp(3) NULL DEFAULT NULL COMMENT '发放奖励时间',
    `created_time`       timestamp(3)                                                  NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `updated_time`       timestamp(3)                                                  NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '更新时间',
    `owning_time`        timestamp(3) NULL DEFAULT NULL COMMENT '奖励所属日期',
    `coin_amount`        decimal(38, 18) unsigned NOT NULL DEFAULT '0.000000000000000000' COMMENT '现货奖励金额',
    `coin_usdt_amount`   decimal(38, 18) unsigned NOT NULL DEFAULT '0.000000000000000000' COMMENT '现货返佣的U的价格',
    `option_amount`      decimal(38, 18) unsigned NOT NULL DEFAULT '0.000000000000000000' COMMENT '合约奖励金额',
    `option_usdt_amount` decimal(38, 18) unsigned NOT NULL DEFAULT '0.000000000000000000' COMMENT '合约返佣的U的价格',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `uniq_business_id` (`business_id`) USING BTREE,
    KEY                  `idx_inviter_user_id` (`inviter_user_id`) USING BTREE,
    KEY                  `idx_reward_status` (`reward_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动-用户奖励记录表';


CREATE TABLE `t_task_reward_record`
(
    `id`           bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `user_id`      bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
    `task_id`      bigint unsigned NOT NULL DEFAULT '0' COMMENT '任务id',
    `amount`       decimal(65, 18)                         NOT NULL DEFAULT '0.000000000000000000' COMMENT '数量',
    `status`       int                                     NOT NULL DEFAULT '0' COMMENT '状态：1: 冻结 2: 解冻 3: 过期',
    `send_status`  int                                     NOT NULL DEFAULT '0' COMMENT '状态：0：待发送 1：已发送',
    `direction`    int                                     NOT NULL DEFAULT '0' COMMENT '类型：1. 收入 2. 支出',
    `request_id`   varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求id',
    `biz_id`       varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '业务id',
    `biz_type`     varchar(32) COLLATE utf8mb4_general_ci  NOT NULL DEFAULT '' COMMENT '业务类型',
    `biz_sub_type` varchar(32) COLLATE utf8mb4_general_ci  NOT NULL DEFAULT '' COMMENT '子业务类型',
    `memo`         varchar(128) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
    `deleted`      int                                     NOT NULL DEFAULT '0' COMMENT '0-未删除 1-已删除',
    `created_at`   timestamp                               NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`   timestamp                               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY            `idx_userid_taskid` (`user_id`,`task_id`),
    KEY            `idx_biz_sub_type` (`biz_sub_type`),
    KEY            `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务奖励流水表';
