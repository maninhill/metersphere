package io.metersphere.base.mapper;

import io.metersphere.base.domain.ApiTestReport;
import io.metersphere.base.domain.ApiTestReportExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ApiTestReportMapper {
    long countByExample(ApiTestReportExample example);

    int deleteByExample(ApiTestReportExample example);

    int deleteByPrimaryKey(String id);

    int insert(ApiTestReport record);

    int insertSelective(ApiTestReport record);

    List<ApiTestReport> selectByExampleWithBLOBs(ApiTestReportExample example);

    List<ApiTestReport> selectByExample(ApiTestReportExample example);

    ApiTestReport selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") ApiTestReport record, @Param("example") ApiTestReportExample example);

    int updateByExampleWithBLOBs(@Param("record") ApiTestReport record, @Param("example") ApiTestReportExample example);

    int updateByExample(@Param("record") ApiTestReport record, @Param("example") ApiTestReportExample example);

    int updateByPrimaryKeySelective(ApiTestReport record);

    int updateByPrimaryKeyWithBLOBs(ApiTestReport record);

    int updateByPrimaryKey(ApiTestReport record);
}