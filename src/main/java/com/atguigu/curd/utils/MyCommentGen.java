package com.atguigu.curd.utils;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.internal.DefaultCommentGenerator;

public class MyCommentGen extends DefaultCommentGenerator {
	@Override
	public void addFieldComment(Field field, IntrospectedTable introspectedTable,
			IntrospectedColumn introspectedColumn) {
		StringBuffer sb = new StringBuffer();
		field.addJavaDocLine("/**");
		if (introspectedColumn.getRemarks() != null)
			field.addJavaDocLine("     *  字段注释 : " + introspectedColumn.getRemarks());
		sb.append("     *   表字段 : ");
		sb.append(introspectedColumn.getActualColumnName());
		field.addJavaDocLine(sb.toString());
		field.addJavaDocLine(" */");
	}
}