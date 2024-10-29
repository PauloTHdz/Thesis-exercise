using Microsoft.EntityFrameworkCore;
using thesis_exercise.Models;

namespace thesis_exercise.Data
{
    public class CatalogContext : DbContext
    {
        public CatalogContext(DbContextOptions<CatalogContext> options) : base(options) { }

        public DbSet<RamConfiguration> RamConfigurations { get; set; }
        public DbSet<StorageDevice> StorageDevices { get; set; }
        public DbSet<Processor> Processors { get; set; }
        public DbSet<ComputerConfiguration> ComputerConfigurations { get; set; }
        public DbSet<PortConfiguration> PortConfigurations { get; set; }

        //TODO: Check what to do with this
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //Configure entity relationships and constraints
            modelBuilder.Entity<ComputerConfiguration>()
                .HasMany(c => c.Ports)
                .WithOne(p => p.ComputerConfiguration)
                .HasForeignKey(p => p.ConfigId);
           
        }

    }
}
