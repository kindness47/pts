INSERT INTO `p_organization`(`id`,`organization_name`,`organization_short_name`,`parent_id`,`level`,`sort`,`status`,`exception_desc`) VALUES
('org-001','内江师范学院','内师','0','1','1',1,''),('org-002','计算机科学学院','计科','org-001','2','1',1,''),
('org-003','教育科学学院','教科','org-001','2','2',1,''),('org-004','新闻学院','新闻','org-001','2','3',1,''),
('org-005','不知名的学院','未知','org-001','2','3',0,'就是不想让你用'),('org-006','体育学院','体院','org-001','2','3',0,'读书不能拯救中国人');

INSERT INTO `p_user` VALUES('p-adasdsd','admin','Administrator','123','超级管理员',1,'','2018-12-05 15:04:32','Administrator','2018-12-05 15:04:32','');