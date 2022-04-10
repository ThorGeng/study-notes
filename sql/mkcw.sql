CREATE TABLE `fpxx` (
  `fpdm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发票代码',
  `fphm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '发票号码',
  `kprq` varchar(255) DEFAULT NULL COMMENT '开票日期',
  `fpzt` varchar(50) DEFAULT NULL COMMENT '发票状态',
  `xshfshh` varchar(255) DEFAULT NULL COMMENT '销售方税号',
  `xshfmch` varchar(255) DEFAULT NULL COMMENT '销售方名称',
  `gmfshh` varchar(255) DEFAULT NULL COMMENT '购买方税号',
  `gmfmch` varchar(255) DEFAULT NULL COMMENT '购买方名称',
  `je` varchar(255) DEFAULT NULL COMMENT '金额',
  `se` varchar(255) DEFAULT NULL COMMENT '税额',
  `jshhj` varchar(255) DEFAULT NULL COMMENT '价税合计',
  `jym` varchar(255) DEFAULT NULL COMMENT '校验码',
  `xshfdzhdh` varchar(255) DEFAULT NULL COMMENT '销售方地址电话',
  `xshfkhhjzhh` varchar(255) DEFAULT NULL COMMENT '销售方开户行及账号',
  `gmfdzhdh` varchar(255) DEFAULT NULL COMMENT '购买方地址电话',
  `gmfkhhjzhh` varchar(255) DEFAULT NULL COMMENT '购买方开户行及账号',
  `mmq` varchar(255) DEFAULT NULL COMMENT '密码区',
  `bzh` varchar(255) DEFAULT NULL COMMENT '备注',
  `kpr` varchar(255) DEFAULT NULL COMMENT '开票人',
  `shkr` varchar(255) DEFAULT NULL COMMENT '收款人',
  `fhr` varchar(255) DEFAULT NULL COMMENT '复核人',
  `fplx` varchar(255) DEFAULT NULL COMMENT '发票类型',
  `jqbh` varchar(255) DEFAULT NULL COMMENT '机器编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci 

CREATE TABLE `hwxx` (
  `fpdm` varchar(255) DEFAULT NULL COMMENT '发票代码',
  `fphm` varchar(255) DEFAULT NULL COMMENT '发票号码',
  `shshflbm` varchar(255) DEFAULT NULL COMMENT '税收分类编码',
  `yshxm` varchar(255) DEFAULT NULL COMMENT '应税项目',
  `ggxh` varchar(255) DEFAULT NULL COMMENT '规格型号',
  `dw` varchar(255) DEFAULT NULL COMMENT '单价',
  `shl` varchar(255) DEFAULT NULL COMMENT '数量',
  `dj` varchar(255) DEFAULT NULL COMMENT '单价',
  `je` varchar(255) DEFAULT NULL COMMENT '金额',
  `taxrate` varchar(255) DEFAULT NULL COMMENT '税率',
  `she` varchar(255) DEFAULT NULL COMMENT '税额'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci 