SELECT province,city,elementary_school_count cnt FROM region WHERE (NOT province = city) ORDER BY elementary_school_count DESC LIMIT 3;