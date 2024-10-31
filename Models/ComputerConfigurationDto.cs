using System.ComponentModel.DataAnnotations;

namespace thesis_exercise.Models
{
    public class ComputerConfigurationDto
    {
        public int RamId { get; set; }
        public int StorageId { get; set; }
        public int ProcessorId { get; set; }
        public List<PortDto> Ports { get; set; } = new List<PortDto>();

    }


    public class ComputerDto
    {
        [Required]
        public required ProcessorDto Processor { get; set; }

        [Required]
        public required StorageDto Storage { get; set; }

        [Required]
        public required RamDto Ram { get; set; }

        [Required]
        public List<PortDto> Ports { get; set; } = new List<PortDto>();

    }


    public class ProcessorDto
    {
        [Required]
        [MaxLength(30)]
        public string Manufacturer { get; set; } = string.Empty;

        [Required]
        [MaxLength(160)]
        public string Description { get; set; } = string.Empty;

    }

    public class StorageDto
    {
        [Required]
        public decimal Capacity { get; set; }

        [Required]
        [MaxLength(2)]
        public string Unit { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string Type { get; set; } = string.Empty;

    }

    public class RamDto
    {
        [Required]
        public int Capacity { get; set; }

        [Required]
        [MaxLength(2)]
        public string Unit { get; set; } = string.Empty;
    }


    public class PortDto
    {
        public string PortType { get; set; } = string.Empty;
        public int PortCount { get; set; }

    }



}
