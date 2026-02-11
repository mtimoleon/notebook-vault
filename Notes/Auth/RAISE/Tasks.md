public class DataciteMetadata  
{  
public string Identifier { get; set; }  
public DataciteTypes Types { get; set; }  
public List\<DataciteCreator\> Creators { get; set; } = [];  
public List\<DataciteTitle\> Titles { get; set; } = [];  
}
 
public class DataciteCreator  
{  
public string CreatorName { get; set; }  
}
 
public class DataciteTitle  
{  
public string Title { get; set; }
 
public string Lang { get; set; }  
}
 
public class DataciteTypes  
{  
public string ResourceType { get; set; }  
public string ResourceTypeGeneral { get; set; }  
}

public class Dataset  
{  
public Guid Id { get; private set; }
 
public Guid UserId { get; private set; }  
public User User { get; private set; }
 
public string Title { get; private set; }
 
public string Description { get; private set; }
 
public DatasetCategory Category { get; private set; }
 
public DateTime? Uploaded { get; private set; }
 
public string Creator { get; private set; }
 
public string Language { get; private set; }
 
public DateTime Created { get; private set; }
 
public string License { get; private set; }
 
public bool IsSampleAvailable { get; private set; }
 
public DatasetSampleType SampleType { get; private set; }  
public DatasetSampleStatus SampleStatus { get; private set; }
 
public bool IsDraft { get; private set; }  
public DatasetStatus Status { get; private set; }
 
private readonly List\<Contributor\> _contributors = new();  
public IReadOnlyCollection\<Contributor\> Contributors =\> _contributors;
 
public DateTime PublicationDate { get; private set; }
 
public bool IsAccessRequestRequired { get; private set; }
 
public bool IsPublic { get; private set; }
 
public Node Node { get; private set; }
 
public string PersistentIdentifier { get; private set; }
 
public float? PlagiarismPercentage { get; private set; }  
public float PopularityScore { get; private set; }
 
public string Extension { get; private set; }
 
public DatasetMetadata Metadata { get; private set; }
 
private readonly List\<DatasetAccessRequest\> _accessRequests = new();  
public IReadOnlyCollection\<DatasetAccessRequest\> AccessRequests =\> _accessRequests;
 
//Publications are not included by default for optimization purposes  
private readonly List\<DatasetPublication\> _publications = new();  
public IReadOnlyCollection\<DatasetPublication\> Publications =\> _publications;
 
//Descriptive Statistics are not included by default for optimization purposes  
public DatasetDescriptiveStatistics DescriptiveStatistics { get; private set; }

![[Tasks - Ink.svg]]
