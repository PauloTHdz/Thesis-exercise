using Microsoft.AspNetCore.Mvc;
using thesis_exercise.Repositories;
using thesis_exercise.Models;
using thesis_exercise.Data;
using Microsoft.Identity.Client.Extensions.Msal;


namespace thesis_exercise.Controllers;

[ApiController]
[Route("[controller]")]
public class ComputerController : ControllerBase
{

    private readonly IConfiguration _configuration;
    private readonly IComputerRepository _computerRepository;
    private readonly CatalogContext _context;

    public ComputerController(IConfiguration configuration, IComputerRepository computerRepository, CatalogContext context)
    {
        this._configuration = configuration;
        this._computerRepository = computerRepository;
        this._context = context;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var configurations = await _computerRepository.GetAllConfigurationAsync();
        return Ok(configurations);
    }

    [HttpPost("AddComputer")]
    public async Task<IActionResult> AddComputer([FromBody] ComputerDto computerDto)
    {
        if (ModelState.IsValid)
        {
            try
            {
                //Map processor data
                var processor = new Processor
                {
                    Manufacturer = computerDto.Processor.Manufacturer,
                    Description = computerDto.Processor.Description
                };

                _context.Processors.Add(processor);
                await _context.SaveChangesAsync();

                //Map storage data
                var storage = new StorageDevice
                {
                    Capacity = computerDto.Storage.Capacity,
                    Unit = computerDto.Storage.Unit,
                    Type = computerDto.Storage.Type
                };

                _context.StorageDevices.Add(storage);
                await _context.SaveChangesAsync();

                // Map RAM data
                var ram = new RamConfiguration
                {
                    Capacity = computerDto.Ram.Capacity,
                    Unit = computerDto.Ram.Unit
                };
                _context.RamConfigurations.Add(ram);
                await _context.SaveChangesAsync();

                // Create and save initial ComputerConfiguration entry without Ports
                var computerConfig = new ComputerConfiguration
                {
                    Processor = processor,
                    Storage = storage,
                    Ram = ram
                };
                _context.ComputerConfigurations.Add(computerConfig);
                await _context.SaveChangesAsync();

                // Retrieve the generated ConfigId
                int configId = computerConfig.ConfigId;

                // Map Port data
                var ports = computerDto.Ports.Select(port => new PortConfiguration
                {
                    ConfigId = configId,    
                    PortType = port.PortType,
                    PortCount = port.PortCount
                }).ToList();

                _context.PortConfigurations.AddRange(ports);
                await _context.SaveChangesAsync();

                // Update the ComputerConfiguration with Ports relationship
                computerConfig.Ports = ports;
                _context.ComputerConfigurations.Update(computerConfig);
                await _context.SaveChangesAsync();

                // Retrieve the generated IDs
                int newProcessorId = processor.ProcessorId;
                int newStorageId = storage.StorageId;

                // Return the IDs in the response
                return Ok(new
                {
                    ConfigId = computerConfig.ConfigId,
                    ProcessorId = newProcessorId,
                    StorageId = newStorageId,
                    RamId = ram.RamId,
                    Message = "Computer configuration added successfully."
                });

            }
            catch (Exception ex)
            {
                return BadRequest($"Error: {ex.Message}");
            }
        }
        return BadRequest("Invalid Data.");

    }

    [HttpPost]
    public async Task<IActionResult> Post()
    {
        return new JsonResult("POST");
    }



}
