using System;
using System.Collections.Generic;
using JustOneBio.Server.Models;
using Microsoft.EntityFrameworkCore;

namespace JustOneBio.Server.Data;

public partial class JustonebioMainContext : DbContext
{
    public JustonebioMainContext(DbContextOptions<JustonebioMainContext> options)
        : base(options)
    {
    }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__tmp_ms_x__3214EC0715E5E3EB");

            entity.ToTable("User");

            entity.Property(e => e.Password).HasMaxLength(100);
            entity.Property(e => e.Username).HasMaxLength(100);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
