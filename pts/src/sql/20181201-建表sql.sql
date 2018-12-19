DROP TABLE IF EXISTS `p_organization`;
CREATE TABLE `p_organization`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `organization_name` VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '组织机构名称',
  `organization_short_name` VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '组织机构简称',
  `parent_id` VARCHAR(36) COLLATE utf8_bin DEFAULT NULL COMMENT '机构上级ID',
  `level` INT(11) DEFAULT NULL COMMENT '菜单等级',
  `sort` INT(11) DEFAULT NULL COMMENT '排序',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='组织机构信息表';

DROP TABLE IF EXISTS `p_project`;
CREATE TABLE `p_project`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `project_id` VARCHAR(36) COLLATE utf8_bin DEFAULT NULL COMMENT '组织机构ID',
  `project_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目编码',
  `project_name` VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '项目名称',
  `supplier` VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '供应商/施工方',
  `contract_sign_time` TIMESTAMP NOT NULL COMMENT '合同签订时间',
  `contract_sign_amount` INT(11) DEFAULT NULL COMMENT '合同签订总额',
  `responsible_person` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目负责人',
  `residue_amount` INT(11) DEFAULT NULL COMMENT '合同剩余金额',
  `is_completion` TINYINT DEFAULT FALSE COMMENT '是否竣工 0在工 1竣工',
  `category` INT(11) DEFAULT NULL COMMENT '项目类别 1施工项目 2采购项目',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='项目信息表';

DROP TABLE IF EXISTS `p_order`;
CREATE TABLE `p_order`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `order_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '订单编码',
  `project_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目编码',
  `order_desc` VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '订单描述',
  `order_amount` INT(11) DEFAULT NULL COMMENT '订单金额',
  `residue_amount` INT(11) DEFAULT NULL COMMENT '订单未支付余额',
  `quality_status` INT(11) DEFAULT NULL COMMENT '订单质量 1好 2不好',
  `quality_remark` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '质量描述',
  `service` INT(11) DEFAULT NULL COMMENT '服务 1好 2不好 ',
  `service_remark` VARCHAR(500) DEFAULT NULL COMMENT '服务描述',
  `level` INT(11) DEFAULT NULL COMMENT '菜单等级',
  `sort` INT(11) DEFAULT NULL COMMENT '排序',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单信息表';

DROP TABLE IF EXISTS `p_settlement`;
CREATE TABLE `p_settlement`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `settlement_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '结算单编码',
  `order_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '订单编码',
  `settlement_amount` INT(11) DEFAULT NULL COMMENT '结算单金额',
  `settlement_open_time` TIMESTAMP NOT NULL COMMENT '结算单开立时间',
  `settlement_delivery_time` DATE DEFAULT NULL COMMENT '结算单送达时间',
  `settlement_delivery_status` INT(11) DEFAULT NULL COMMENT '结算单送达状态 1正常 2异常',
  `settlement_delivery_remark` VARCHAR(500) DEFAULT NULL COMMENT '结算单送达状态描述',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='结算单信息表';

DROP TABLE IF EXISTS `p_payment`;
CREATE TABLE `p_payment`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `payment_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '支付编码',
  `settlement_code` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '结算单编码',
  `payment_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
  `payment_status` INT(11) DEFAULT NULL COMMENT '支付状态',
  `payment_remark` VARCHAR(500) DEFAULT NULL COMMENT '支付描述',
  `bill_delivery_time` DATE DEFAULT NULL COMMENT '发票送达时间',
  `bill_delivery_status` INT(11) DEFAULT NULL COMMENT '发票送达状态 1正常 2异常',
  `bill_delivery_remark` VARCHAR(500) DEFAULT NULL COMMENT '发票送达描述',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='支付信息表';

DROP TABLE IF EXISTS `p_user`;
CREATE TABLE `p_user`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `account` VARCHAR(32) COLLATE utf8_bin NOT NULL COMMENT '账户名',
  `username` VARCHAR(32) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` VARCHAR(60) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `role_name` VARCHAR(32) COLLATE utf8_bin NOT NULL DEFAULT '普通用户' COMMENT '角色',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户信息表';

DROP TABLE IF EXISTS `p_permissions`;
CREATE TABLE `p_permissions`(
  `id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '主键ID UUID',
  `user_id` VARCHAR(36) COLLATE utf8_bin NOT NULL COMMENT '用户ID',
  `permission` VARCHAR(32) COLLATE utf8_bin NOT NULL COMMENT '权限名',
  `permission_type` INT(11) NOT NULL COMMENT '权限类型',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限信息表';

DROP TABLE IF EXISTS `p_menu`;
CREATE TABLE `p_menu`(
  `id` INT(11) NOT NULL COMMENT 'ID int',
  `menu_code` VARCHAR(32) COLLATE utf8_bin NOT NULL COMMENT '菜单编码',
  `menu_name` VARCHAR(32) COLLATE utf8_bin NOT NULL COMMENT '菜单名',
  `parent_code` INT(11) NOT NULL COMMENT '父ID int',
  `url` VARCHAR(32) DEFAULT '' COMMENT 'url',
  `level` INT(11) NOT NULL COMMENT 'level',
  `menu_class` VARCHAR(32) DEFAULT '' COMMENT '图标',
  `function_type` INT(11) COMMENT '菜单功能',
  `sort` INT(11) NOT NULL COMMENT 'sort',
  `title` VARCHAR(32) COLLATE utf8_bin DEFAULT '' COMMENT '标题',
  `status` INT(11) DEFAULT NULL COMMENT '状态 1可用 0不可用',
  `exception_desc` VARCHAR(500) COLLATE utf8_bin DEFAULT NULL COMMENT '异常描述',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` VARCHAR(32) COLLATE utf8_bin DEFAULT NULL COMMENT '更新人'
)ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜单信息表';
