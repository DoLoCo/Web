class AddingCalculateDistanceFunction < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute(
      "
CREATE FUNCTION calculate_distance(lat1 decimal(20, 10), lon1 decimal(20, 10), lat2 decimal(20, 10), lon2 decimal(20, 10)) returns decimal(20, 10)
BEGIN
  declare d_lat decimal(20, 10);
  declare d_lon decimal(20, 10);
  declare a decimal(20, 10);
  declare c decimal(20, 10);
  declare d decimal(20, 10);
  
  set d_lat = RADIANS(lat2 - lat1);
  set d_lon = RADIANS(lon2 - lon1);
  
  set a = SIN(d_lat / 2) * SIN(d_lat / 2) + COS(RADIANS(lat1)) * COS(RADIANS(lat2)) * SIN(d_lon / 2) * SIN(d_lon / 2);
 
  set c = 2 * ATAN2(SQRT(a), SQRT(1 - a));
  
  set d = 6371 * c;
 
  return d;
END;"
    )
  end

  def down
    ActiveRecord::Base.connection.execute("DROP FUNCTION IF EXISTS calculate_distance")
  end
end
