INSERT INTO user (id, name, email, password, status, create_time, update_time, language, last_workspace_id, last_organization_id, phone)
VALUES ('admin', 'Administrator', 'admin@fit2cloud.com', md5('fit2cloud'), '1', 1582597567455, 1582597567455, null, '', null, null);

INSERT INTO user_role (id, user_id, role_id, source_id, create_time, update_time)
VALUES (uuid(), 'admin', 'admin', '1', 1581576575948, 1581576575948);

INSERT INTO role (id, name, description, type, create_time, update_time)
VALUES ('admin', '系统管理员', NULL, NULL, 1581576575948, 1581576575948);
INSERT INTO role (id, name, description, type, create_time, update_time)
VALUES ('org_admin', '组织管理员', NULL, NULL, 1581576575948, 1581576575948);
INSERT INTO role (id, name, description, type, create_time, update_time)
VALUES ('test_manager', '测试经理', NULL, NULL, 1581576575948, 1581576575948);
INSERT INTO role (id, name, description, type, create_time, update_time)
VALUES ('test_user', '测试人员', NULL, NULL, 1581576575948, 1581576575948);
INSERT INTO role (id, name, description, type, create_time, update_time)
VALUES ('test_viewer', 'Viewer', NULL, NULL, 1581576575948, 1581576575948);

INSERT INTO test_case_report_template (id, name, content)
VALUES (uuid(), 'default', '{\"components\": [1,2,3,4,5]}');
INSERT INTO system_parameter (param_key, param_value, type, sort)
VALUES ('default.language', 'zh_CN', 'text', 5);