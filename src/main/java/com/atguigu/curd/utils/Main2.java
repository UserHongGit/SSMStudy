package com.atguigu.curd.utils;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


/**
 * 自定义修改注释生成类
 */
public class Main2 {
	
	/**
	 * 这里输入需要生成文件的表名
	 */
	String tableName = "tbl_dept";
	/**
	 * 这里输入想要生成的java实体类的名字,如此时生成后为
	 * DwEntity.java
	 * DwEntityMapper.java
	 * DwEntityMapper.xml
	 */
	String entityName = "Department";
	
	
	public void changeTableName() throws IOException {
		File file = new File("generatorConfig.xml");
		
		StringBuffer buf = new StringBuffer();  
		InputStreamReader isr = new InputStreamReader(new FileInputStream(file));
		BufferedReader br = new BufferedReader(isr);
		   String lineTxt = null;
		while((lineTxt = br.readLine()) != null) {
			if(lineTxt.indexOf("<table tableName")!=-1) {
				 buf.append("<table  tableName=\""+tableName+"\" domainObjectName=\""+entityName+"\"></table>"+"\n");
			}else {
				 buf.append(lineTxt+"\n");
			}
		}
		br.close();
		FileWriter fw = new FileWriter((file));
		fw.write(buf.toString());
		fw.flush();
		fw.close();
	}
	
	
	public void gengerator() throws Exception{
		changeTableName();
		List<String> warnings = new ArrayList<String>();
		boolean  overwrite = true;
		File configFile = new File("generatorConfig.xml");
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
		System.out.println("已将文件生成在pojo包下!!!");
	}
	public static void main(String[] args) {
		try {
			Main2 main = new Main2();
			main.gengerator();
			//main.changeTableName();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
