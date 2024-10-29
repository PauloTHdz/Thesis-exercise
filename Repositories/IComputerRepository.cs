using thesis_exercise.Models;

namespace thesis_exercise.Repositories
{
    
    public interface IComputerRepository
    {
        Task<List<ComputerConfiguration>> GetAllConfigurationAsync();

    }

}
