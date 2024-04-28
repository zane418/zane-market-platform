CREATE DATABASE `market_platform`  DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  DEFAULT ENCRYPTION = 'N';


create table market_platform.strategy
(
    id            bigint unsigned                    not null comment '主键ID'
        primary key,
    creator       bigint                             null comment '创建者ID',
    updater       bigint                             null comment '最后更新者',
    create_time   datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    version       bigint   default 0                 not null comment '乐观锁版本号',
    delete_flag   bit      default b'0'              not null comment '删除标记',
    strategy_id   bigint                             not null comment '抽奖策略ID',
    strategy_desc varchar(128)                       not null comment '抽奖策略描述'
)
    charset = utf8mb4;

create index idx_strategy_id
    on market_platform.strategy (strategy_id);

create table market_platform.strategy_award
(
    id                  bigint unsigned                    not null comment '主键ID'
        primary key,
    creator             bigint                             null comment '创建者ID',
    updater             bigint                             null comment '最后更新者',
    create_time         datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    version             bigint   default 0                 not null comment '乐观锁版本号',
    delete_flag         bit      default b'0'              not null comment '删除标记',
    strategy_id         bigint                             not null comment '抽奖策略ID',
    award_id            int                                not null comment '抽奖奖品ID - 内部流转使用',
    award_title         varchar(128)                       not null comment '抽奖奖品标题',
    award_subtitle      varchar(128)                       null comment '抽奖奖品副标题',
    award_count         int      default 0                 not null comment '奖品库存总量',
    award_count_surplus int      default 0                 not null comment '奖品库存剩余',
    award_rate          decimal(6, 4)                      not null comment '奖品中奖概率',
    rule_models         varchar(256)                       null comment '规则模型，rule配置的模型同步到此表，便于使用',
    sort                int      default 0                 not null comment '排序'
)
    charset = utf8mb4;

create index idx_strategy_id_award_id
    on market_platform.strategy_award (strategy_id, award_id);

create table market_platform.strategy_rule
(
    id          bigint unsigned                      not null comment '主键ID'
        primary key,
    creator     bigint                               null comment '创建者ID',
    updater     bigint                               null comment '最后更新者',
    create_time datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    version     bigint     default 0                 not null comment '乐观锁版本号',
    delete_flag bit        default b'0'              not null comment '删除标记',
    strategy_id int                                  not null comment '抽奖策略ID',
    award_id    int                                  null comment '抽奖奖品ID【规则类型为策略，则不需要奖品ID】',
    rule_type   tinyint(1) default 0                 not null comment '抽象规则类型；1-策略规则、2-奖品规则',
    rule_model  varchar(16)                          not null comment '抽奖规则类型【rule_random - 随机值计算、rule_lock - 抽奖几次后解锁、rule_luck_award - 幸运奖(兜底奖品)】',
    rule_value  varchar(64)                          not null comment '抽奖规则比值',
    rule_desc   varchar(128)                         not null comment '抽奖规则描述'
)
    charset = utf8mb4;

create index idx_strategy_id_award_id
    on market_platform.strategy_rule (strategy_id, award_id);

