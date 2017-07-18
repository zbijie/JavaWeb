package com.fzy.common.util;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BaseMapper<T> {
	
	/**
	 * 保存对象
	 * 
	 * @param entity 对象实例
	 */
	public int save(T entity);
	
	/**
	 * 更新对象
	 * 
	 * @param entity 对象实例
	 */
	public void update(T entity);
	  
	/**
	 * 删除对象
	 * 
	 * @param id 对象主键
	 */
    public void delete(int id);
    
    /**
     * 根据主键查询
     * 
     * @param id 对象主键
     * @return T 对象实例
     */
    public T findById(int id);
    
    /**
     * 根据条件查看记录数
     * 
     * @param whereCondition  	查询条件
     * @return int 				记录数
     */
    public int countByCondition(@Param(value="whereCondition")String whereCondition);
    
    /**
     * 根据条件查看对象集合
     * 
     * @param whereCondition  	查询条件
     * @return List<T> 			对象集合
     */
    public List<T> findByCondition(@Param(value="whereCondition")String whereCondition);

}
