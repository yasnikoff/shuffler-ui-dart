package main

import (
	//"os"
	"path/filepath"

	"bitbucket.org/yasnikoff/shuffler/internal/repo"
	"bitbucket.org/yasnikoff/shuffler/types/id"
	"log"
	"github.com/pkg/errors"
	"bitbucket.org/yasnikoff/shuffler"
	"image/color"
	_ "image/jpeg"
	"image"
	"image/jpeg"
	"os"
	"golang.org/x/image/draw"
	"fmt"
)

func main() {
	root:="root"
	if err:=os.RemoveAll(root);err!=nil{
		log.Fatal(errors.Wrapf(err, "can't remove root dir for test data"))
	}
	for _, rd := range testData {
		if err := rd.Create(root); err != nil {
			log.Fatal(err)
		}
	}
}

var testData []*repoData = []*repoData{
	{
		Name:"repo 1",
		Projects:[]*projectData{
			{
				Name:"project 1",
				ID: 1,
				AddToRecent:true,
				PreviewColor:color.RGBA{100, 100, 127, 0},
				Tags:[]string{"tag 1", "tag 2"},
				Deps:[]depData{
					{
						SubPath:"links/dep1",
						Data:DescData{ID:2},
					},
					{
						SubPath:"links/dep2",
						Data:DescData{ID:4},
					},
				},
			},
			{
				Name:"project 2",
				ID: 2,
				AddToRecent:true,
				PreviewColor:color.RGBA{127, 127, 127, 0},
				Tags:[]string{"tag 21", "tag 22"},

			},
			{
				Name:"",
				AddToRecent:true,
				PreviewColor:color.RGBA{0, 0, 0, 0},

			},
			{
				Name:"project 4",
				ID:4,
				AddToRecent:false,
				PreviewColor:color.RGBA{127, 50, 50, 0},

			},
		},
	},
	{
		Name:"repo 2",
		Projects:[]*projectData{
			{
				Name:"project 21",
				AddToRecent:true,
				Tags:[]string{"tag1", "tag 2"},
			},
			{
				Name:"project 22",
				AddToRecent:true,
			},
			{
				Name:"project 23",
				AddToRecent:false,
			},
		},
	},
}

type DescData struct {
	ID byte
}

type depData struct {
	SubPath string
	Data    interface{}
}

type projectData struct {
	Name         string
	ID           byte
	AddToRecent  bool
	PreviewColor color.RGBA
	Tags         []string
	Deps         []depData
}

func IDfromNum(n byte) (id.ID, error) {
	if n != 0 {
		idstr := fmt.Sprintf("00000000-0000-0000-0000-000000000%03d", n)
		prID, err := id.Parse(idstr)
		if err != nil {
			return id.Zero, fmt.Errorf("can't parse ID from: %s", idstr)
		} else {
			return prID, nil
		}
	} else {
		return id.New(), nil
	}
}

func (pd *projectData)Create(parentDir string) (*shuffler.Project, error) {
	pr := shuffler.NewProject();

	// ID
	prID, err := IDfromNum(pd.ID)
	if err != nil {
		return nil, errors.Wrapf(err, "can't create project from data %s", pd)
	}
	pr.SetID(prID)

	// Path
	path := filepath.Join(parentDir, pr.ID().String())

	//Name
	pr.SetName(pd.Name)


	//tags
	pr.Tags.Add(pd.Tags...)

	//deps
	for _, d := range pd.Deps {
		var dep shuffler.Dependency
		data := d.Data
		switch data := data.(type){
		case DescData:
			depId, err := IDfromNum(data.ID)
			if err != nil {
				return nil, errors.Wrap(err, "can't create project's dependency")
			}
			dep = &shuffler.DepDesc{IDData:depId}
		default:
			return nil, fmt.Errorf("dep type is not supported: %#v", d)
		}
		pr.Deps.Add(d.SubPath, dep)
	}



	// SAVE

	if err := pr.SaveTo(path); err != nil {
		return nil, errors.Wrapf(err, "can't create project %q", pd.Name)
	}

	// create preview image

	rect := image.Rect(0, 0, 512, 512)
	img := image.NewRGBA(rect)

	draw.Draw(img, rect, image.NewUniform(pd.PreviewColor), image.ZP, draw.Src)
	file, err := os.Create(pr.PreviewPath())
	if err != nil {
		return nil, errors.Wrapf(err, "can't create preview file for %q at %q", pr.ID(), pr.PreviewPath())
	}
	if err := jpeg.Encode(file, img, nil); err != nil {
		return nil, errors.Wrapf(err, "can't encode preview file for %q at %q", pr.ID(), pr.PreviewPath())

	}

	return pr, nil
}

type repoData struct {
	Name     string
	Projects []*projectData
}

func (rd *repoData)Create(root string) error {
	repoPath := filepath.Join(root, rd.Name)
	//if err :=os.MkdirAll(repoPath, os.ModeDir);err!=nil{
	//	return err
	//}
	r := repo.New()
	r.SetName(rd.Name)
	if err := r.SaveTo(repoPath); err != nil {
		return errors.Wrapf(err, "can't create repo %q", rd.Name)
	}

	for _, prData := range rd.Projects {

		if pr, err := prData.Create(repoPath); err != nil {
			return errors.Wrapf(err, "can't create repo %q", rd.Name)
		} else {
			if prData.AddToRecent {
				r.AddToRecent(pr.ID())
			}
		}
	}
	return r.UpdateIndex();
}

