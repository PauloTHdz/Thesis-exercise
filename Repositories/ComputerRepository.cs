using Microsoft.EntityFrameworkCore;
using thesis_exercise.Data;
using thesis_exercise.Models;


namespace thesis_exercise.Repositories
{
   
    public class ComputerRepository : IComputerRepository
    {
        private readonly CatalogContext _context;

        public ComputerRepository(CatalogContext context)
        {
            _context = context;
        }

        public async Task<List<ComputerConfiguration>> GetAllConfigurationAsync()
        {
            return await _context.ComputerConfigurations
                .Include(c => c.Ram)
                .Include(c => c.Storage)
                .Include(c => c.Processor)
                .Include(c => c.Ports)
                .ToListAsync(); 
        }

    }

}
