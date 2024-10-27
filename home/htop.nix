{ ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      show_cpu_temperature = 1;
      column_meters_0 = "AllCPUs Memory Swap";
      column_meter_modes_0 = "1 1 1";
      column_meters_1 = "Tasks LoadAverage Uptime NetworkIO DiskIO HugePages";
      column_meter_modes_1 = "2 2 2 2 2 1";
    };
  };
}
