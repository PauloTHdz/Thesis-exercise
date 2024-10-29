using Microsoft.AspNetCore.Mvc;
using thesis_exercise.Repositories;
using thesis_exercise.Models;


namespace thesis_exercise.Controllers;

[ApiController]
[Route("[controller]")]
public class ComputerController : ControllerBase
{

    private readonly IConfiguration _configuration;
    private readonly IComputerRepository _computerRepository;

    public ComputerController(IConfiguration configuration, IComputerRepository computerRepository)
    {
        this._configuration = configuration;
        this._computerRepository = computerRepository;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var configurations = await _computerRepository.GetAllConfigurationAsync();  
        return Ok(configurations);
    }

    [HttpPost]
    public async Task<IActionResult> Post()
    {
        return new JsonResult("POST");
    }
}
