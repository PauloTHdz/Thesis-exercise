
using System.ComponentModel.DataAnnotations;

namespace thesis_exercise.Models
{
    public class ComputerConfiguration
    {
        [Key]
        public int ConfigId { get; set; }
        public RamConfiguration? Ram { get; set; }
        public StorageDevice? Storage { get; set; }
        public Processor? Processor { get; set; }

        //Relationship
        public List<PortConfiguration>? Ports { get; set; } 


    }

    public class Processor
    {
        [Key]
        public int ProcessorId { get; set; }
        public string Manufacturer { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;

    }

    public class StorageDevice
    {
        [Key]
        public int StorageId { get; set; }
        public decimal Capacity { get; set; }
        public string Unit { get; set; } = string.Empty;
        public string Type { get; set; } = string.Empty;

    }

    public class RamConfiguration
    {
        [Key]
        public int RamId { get; set; }
        public int Capacity { get; set; }
        public string Unit { get; set; } = string.Empty;
    }

    public class PortConfiguration
    {
        [Key]
        public int PortConfigId { get; set; }
        public int ConfigId { get; set; }
        public string PortType { get; set; } = string.Empty;
        public int PortCount { get; set; }

        //Navigation property
        public ComputerConfiguration? ComputerConfiguration { get; set; }        
    }

}
