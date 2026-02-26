---
categories:
  - "[[Work]]"
created: 2026-02-26
product:
component:
tags:
  - documentation/intelligen
  - topic/automapper
  - topic/code
---
## Summary
An extension to use in automapper configuration and ignore some specific types from mapping.

## Details
#### Implementation

```csharp
using AutoMapper;
using AutoMapper.Internal;
using System;
​
namespace Planning.Api.Helpers
{
    public static class AutoMapperConfigurationExtensions
    {
        public static void IgnoreDomainEvents(this IMapperConfigurationExpression cfg)
        {
            if (cfg == null)
                throw new ArgumentNullException(nameof(cfg));
​
            // Apply once per configuration: any destination type that exposes DomainEvents should ignore it.
            cfg.Internal().ForAllMaps((typeMap, mapExpr) =>
            {
                if (typeMap?.DestinationType?.GetProperty("DomainEvents") != null)
                    mapExpr.ForMember("DomainEvents", opt => opt.Ignore());
            });
        }
    }
}
```

#### Usage in configuration of mapper

Central:
```csharp
services.AddAutoMapper(opt =>
{
	opt.IgnoreDomainEvents();
	opt.AddExpressionMapping();
	opt.AddProfile(typeof(AutoMapperCoreProfile));
	opt.AddProfile(typeof(AutoMapperEventsProfile));
	opt.AddProfile(typeof(AutomapperProductionProfile));
});
```

in specific configuration:
```csharp
var mapperConfiguration = new MapperConfiguration(cfg =>
{
	cfg.AddProfile<AutoMapperCoreProfile>();
	cfg.AddProfile<AutoMapperProcedureLookupProfile>();
	cfg.IgnoreDomainEvents();
});
```

## Links
